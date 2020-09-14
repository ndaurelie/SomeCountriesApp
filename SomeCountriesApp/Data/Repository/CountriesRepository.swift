//
//  CountriesRepository.swift
//  SomeCountriesApp
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import ObjectMapper
import RxSwift

class CountriesRepository: CountriesRepositoryProtocol {
    private let provider: MoyaProvider<CountriesApi>
    
    init(provider: MoyaProvider<CountriesApi>) {
        self.provider = provider
    }
    
    func getCountries(name: String) -> Single<[Country]> {
        return self.provider.rx.request(.getCountries(name: name))
            .debug()
            .filterSuccessAndTransformError()
            .map { response -> [Country] in
                guard let countriesCollection = try? response.mapArray(Country.self) else {
                    return [Country]()
                }
                return countriesCollection
            }
            .observeOn(MainScheduler.instance)
    }
}
