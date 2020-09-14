//
//  SearchCountriesViewModel.swift
//  SomeCountriesApp
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import Foundation
import RxCocoa
import RxDataSources
import RxSwift

enum SearchCountriesViewModelState: Equatable {
    case idle
    case loading
    case countriesOK([Country])
    case error(String)
}

class SearchCountriesViewModel {
    let disposeBag = DisposeBag()
    let state = BehaviorSubject<SearchCountriesViewModelState>(value: .idle)
    let countriesData = BehaviorSubject<[CountrySection]>(value: [])
    let displayCountries = PublishSubject<String>()
    
    private let countryRepository: CountriesRepositoryProtocol
    
    init(countryRepository: CountriesRepositoryProtocol) {
        self.countryRepository = countryRepository
        
        displayCountries.flatMapLatest { [weak self] (name: String) -> Observable<SearchCountriesViewModelState> in
            guard let self = self else { return Observable.just(SearchCountriesViewModelState.error("Unknown error")) }
            
            return self.countryRepository.getCountries(name: name).debug().asObservable()
                .map { [weak self] (listOfCountries: [Country]) -> SearchCountriesViewModelState in
                    guard let self = self else { return SearchCountriesViewModelState.error("Unknown error") }
                    
                    self.countriesData.onNext([CountrySection(items: listOfCountries)])
                    return SearchCountriesViewModelState.countriesOK(listOfCountries)
                }
                .catchError { error -> Observable<SearchCountriesViewModelState> in
                    return Observable.just(SearchCountriesViewModelState.error(error.localizedDescription))
                }
                .startWith(.loading)
            }
            .subscribe(state)
            .disposed(by: disposeBag)
    }
    
    func getCountriesData(name: String) {
        guard !name.isEmpty else {
            return
        }
        displayCountries.onNext(name)
    }
}
