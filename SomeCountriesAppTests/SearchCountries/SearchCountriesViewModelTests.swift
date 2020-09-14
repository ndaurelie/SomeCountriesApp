//
//  SearchCountriesViewModelTests.swift
//  SomeCountriesAppTests
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import Moya
import Nimble
import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import SomeCountriesApp

class SearchCountriesViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        self.disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        self.disposeBag = nil
        super.tearDown()
    }
    
    func testGetCountriesSucceeded() {
        let fakeRepository = CountriesRepositoryMock()
        let viewModel = SearchCountriesViewModel(countryRepository: fakeRepository)
        
        var states = [SearchCountriesViewModelState]()
        
        viewModel.state
            .subscribe(onNext: { state in
                states.append(state)
            })
            .disposed(by: disposeBag)
        
        viewModel.getCountriesData(name: "test")
        
        let expectedCountry = Country(name: "Germany",
                                      alpha3Code: "DEU",
                                      capital: "Berlin",
                                      region: "Europe")
        let expectedStates: [SearchCountriesViewModelState] = [.idle, .loading, .countriesOK([expectedCountry])]
        
        expect(states).to(equal(expectedStates))
    }
    
    func testGetCountriesSucceedsWhenEmptyName() {
        let fakeRepository = CountriesRepositoryMock()
        let viewModel = SearchCountriesViewModel(countryRepository: fakeRepository)
        
        var states = [SearchCountriesViewModelState]()
        
        viewModel.state
            .subscribe(onNext: { state in
                states.append(state)
            })
            .disposed(by: disposeBag)
        
        viewModel.getCountriesData(name: "")
        
        let expectedStates: [SearchCountriesViewModelState] = [.idle]
        
        expect(states).to(equal(expectedStates))
    }
}
