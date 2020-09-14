//
//  CountriesApi.swift
//  SomeCountriesApp
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import Foundation
import Moya

enum CountriesApi {
    case getCountries(name: String)
}

extension CountriesApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://restcountries.eu/rest/v2")!
    }
    
    var path: String {
        switch self {
        case .getCountries(let name):
            return "/name/\(name)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCountries:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getCountries:
            guard let url = Bundle.main.url(forResource: "GET_countries_name_fran", withExtension: "json"), let data = try? Data(contentsOf: url) else {
                return Data()
            }
            return data
        }
    }
    
    var task: Task {
        switch self {
        case .getCountries:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
