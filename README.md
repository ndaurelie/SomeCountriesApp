# SomeCountriesApp
A simple iOS app using the MVVM pattern and RxSwift framework, and querying the REST Countries API (https://restcountries.eu/) based on a search term.

# Usage
This project uses CocoaPods, therefore to get started you must first install the dependencies: open Terminal and run `pod install`. Then open the workspace in Xcode, and select the SomeCountriesApp target, build and run.

# Summary
In the `Search countries` screen, there is a searchBar to look for countries containing a (partial) name. The result of the search is displayed using a tableView, with a cell for each country of this list. When selecting a country, the user can see more details about this country in a `Country details` screen.

MVVM pattern is used, to keep the viewController lighter and to implement the tests.

RxSwift, Moya are used for the networking part, and ObjectMapper for mapping the JSON to the model.

The RxDataSources library is used to display the tableView with RxSwift.

In the unit tests, I used Nimble to have more legible comparison states. I also included RxTest and RxBlocking libraries for the tests with rx.
