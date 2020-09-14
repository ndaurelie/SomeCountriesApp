//
//  CountriesRepositoryProtocol.swift
//  SomeCountriesApp
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift

protocol CountriesRepositoryProtocol {
    func getCountries(name: String) -> Single<[Country]>
}

