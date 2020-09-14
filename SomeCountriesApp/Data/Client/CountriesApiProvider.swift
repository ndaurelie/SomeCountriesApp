//
//  CountriesApiProvider.swift
//  SomeCountriesApp
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import Foundation
import Moya

class CountriesApiProvider: MoyaProvider<CountriesApi> {
    
    static let instance = MoyaProvider<CountriesApi>()
    
    private let provider: MoyaProvider<CountriesApi>
    
    init(provider: MoyaProvider<CountriesApi>) {
        self.provider = provider
    }
}
