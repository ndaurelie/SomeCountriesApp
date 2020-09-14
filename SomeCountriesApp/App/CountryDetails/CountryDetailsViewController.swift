//
//  CountryDetailsViewController.swift
//  SomeCountriesApp
//
//  Created by Aurélie Nouaille-Degorce on 14/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var nativeNameLabel: UILabel!
    
    var selectedCountry: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let country = selectedCountry else {
            print("No country to show")
            return
        }
        
        displayCountryInformation(country: country)
    }
    
    private func displayCountryInformation(country: Country) {
        titleLabel.text = country.name
        capitalLabel.text = "Capital: " + country.capital
        regionLabel.text = "Region: " + country.region
        nativeNameLabel.text = "Native name: " + country.nativeName
    }
}
