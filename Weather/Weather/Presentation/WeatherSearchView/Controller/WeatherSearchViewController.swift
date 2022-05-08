//
//  FirstViewController.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/04.
//

import UIKit

final class WeatherSearchViewController: UIViewController {

    @IBOutlet weak var weatherSearchBar: UISearchBar!
    @IBOutlet weak var weatherSearchResultsTableView: UITableView!
    
    static let storyboardName = "Main"
    static let storyboardID = "WeatherSearchViewControllerID"
    
    private var weatherSearchViewModel: WeatherSearchViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherSearchBar.delegate = self
        self.weatherSearchResultsTableView.dataSource = self
        self.weatherSearchResultsTableView.delegate = self
    }
    
    static func create(with viewModel: WeatherSearchViewModel) -> WeatherSearchViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID) as? WeatherSearchViewController else { return WeatherSearchViewController() }
        viewController.weatherSearchViewModel = viewModel
        return viewController
    }

    private func bind() {
        self.weatherSearchViewModel.searchResultsStorage.bind { [weak self] _ in
            guard let self = self else { return }
            self.weatherSearchResultsTableView.reloadData()
        }
        self.weatherSearchViewModel.isError.bind { [weak self] isError in
            guard let self = self else { return }
            guard let error = self.weatherSearchViewModel.error.value else { return }
            self.presentErrorAlert(of: error)
        }
    }
    
    private func presentErrorAlert(of error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        let addErrorAlertAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(addErrorAlertAction)
        self.present(errorAlert, animated: true, completion: nil)
    }

}

extension WeatherSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherSearchViewModel.searchResultsStorage.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherSearchResultTableViewCellID", for: indexPath) as? WeatherSearchResultTableViewCell else { return UITableViewCell() }
        cell.configure(at: indexPath.row, with: self.weatherSearchViewModel.searchResultsStorage.value)
        return cell
    }
    
}

extension WeatherSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let woeid = self.weatherSearchViewModel.searchResultsStorage.value[indexPath.row].woeid
        self.weatherSearchViewModel.didSelectItem(at: indexPath.row, woeid: woeid)
    }
    
}

extension WeatherSearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        self.weatherSearchViewModel.didSearch(using: searchText)
        self.bind()
    }

}
