//
//  ViewController.swift
//  SomeCountriesApp
//
//  Created by Aurélie Nouaille-Degorce on 13/09/2020.
//  Copyright © 2020 Aurélie Nouaille-Degorce. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxDataSources
import RxSwift

class SearchCountriesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    lazy var viewModel: SearchCountriesViewModel = {
        SearchCountriesViewModel(countryRepository: CountriesRepositoryFactory.get())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindSearchBar()
        bindTableView()
        bindToViewModel()
    }
    
    private func setupUI() {
        self.title = "Search Countries"
        self.tableView.tableFooterView = UIView()
        self.tableView.isHidden = true
    }
    
    private func bindSearchBar() {
        searchBar
            .rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] name in
                guard let self = self else { return }
                self.viewModel.getCountriesData(name: name)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        let dataSource = RxTableViewSectionedReloadDataSource<CountrySection>(configureCell: { (datasource, tableview, indexpath, item) -> UITableViewCell in
            
            let cell = tableview.dequeueReusableCell(withIdentifier: "CountryCell", for: indexpath)
            cell.textLabel?.text = item.name
            return cell
        })
        
        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.tableView.deselectRow(at: indexPath, animated: false)
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(Country.self).subscribe(onNext: { [weak self] country in
                guard let self = self else { return }
                self.performSegue(withIdentifier: "ShowCountryDetailsSegue", sender: country)
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.countriesData
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func bindToViewModel() {
        viewModel.state
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                (state == .loading) ? self.startLoader() : self.stopLoader()
                
                switch state {
                case .error(let message):
                    self.showError(message: message)
                default: break
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func startLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func stopLoader() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? CountryDetailsViewController {
            if let country = sender as? Country {
                detailsVC.selectedCountry = country
            }
        }
    }
    
}

extension SearchCountriesViewController: UIScrollViewDelegate {
    
}

