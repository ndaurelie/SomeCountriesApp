//
//  CountriesTests.swift
//  SomeCountriesAppTests
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import XCTest

@testable import SomeCountriesApp

class CountriesTests: XCTestCase {

    func testCountriesDecodable() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "GET_countries_name_fran", withExtension: "json"), let data = try? Data(contentsOf: url) else {
            return
        }
        let decoder = JSONDecoder()
        guard let countries = try? decoder.decode([Country].self, from: data) else {
            return
        }
        XCTAssertEqual(countries.count, 2)
        XCTAssertEqual(countries[0].name, "France")
    }
}
