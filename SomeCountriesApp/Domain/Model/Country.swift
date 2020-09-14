//
//  Country.swift
//  SomeCountriesApp
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

struct Country {
    let name: String
    let alpha3Code: String
    let capital: String
    let region: String
}

extension Country: Codable {
    
}

extension Country: Equatable {
    
}

extension Country: ImmutableMappable {
    init(map: Map) throws {
        name = try map.value("name")
        alpha3Code = try map.value("alpha3Code")
        capital = try map.value("capital")
        region = try map.value("region")
    }
}

struct CountrySection {
    var items: [Item]
}

extension CountrySection: SectionModelType {
    typealias Item = Country
    
    init(original: CountrySection, items: [Country]) {
        self = original
        self.items = items
    }
}
