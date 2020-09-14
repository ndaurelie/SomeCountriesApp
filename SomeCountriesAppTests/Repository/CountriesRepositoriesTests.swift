//
//  CountriesRepositoriesTests.swift
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

class CountriesRepositoriesTests: XCTestCase {
    var disposeBag: DisposeBag!
    var provider: MoyaProvider<CountriesApi>!
    
    override func setUp() {
        super.setUp()
        
        disposeBag = DisposeBag()
        self.provider = MoyaProvider(endpointClosure: { target in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: {
                              EndpointSampleResponse.networkResponse(200, target.sampleData)
                            },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: [:])
                       },
                                     stubClosure: MoyaProvider.immediatelyStub)
    }
    
    override func tearDown() {
        disposeBag = nil
        
        super.tearDown()
    }
    
    func testGetCountriesSucceeded() {
        let countriesRepository = CountriesRepository(provider: CountriesApiProvider(provider: provider))
        var results = [[Country]]()
        var errors = [Error]()
        
        countriesRepository.getCountries(name: "")
            .asObservable()
            .subscribe(onNext: { result in
                results.append(result)
            },
                       onError: { error in
                        errors.append(error)
            })
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now()  + 1) {
            expect(results.count).to(equal(1))
            expect(errors).to(beEmpty())
            expect(results[0].count).to(equal(2))
        }
    }
}
