//
//  CountriesRepositoryMock.swift
//  SomeCountriesAppTests
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import Foundation
import RxSwift

@testable import SomeCountriesApp

class CountriesRepositoryMock: CountriesRepositoryProtocol {
    func getCountries(name: String) -> Single<[Country]> {
        let testCountry = Country(name: "Germany",
                                  alpha3Code: "DEU",
                                  capital: "Berlin",
                                  region: "Europe")
        return Single.just([testCountry])
    }
}
