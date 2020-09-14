//
//  CountriesRepositoryFactory.swift
//  SomeCountriesApp
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import Foundation

class CountriesRepositoryFactory {
    class func get() -> CountriesRepositoryProtocol {
        return CountriesRepository(provider: CountriesApiProvider.instance)
    }
}
