//
//  SearchViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/23/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class SearchViewController: ViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!

    var viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupData() {
        super.setupData()
        viewModel.loadKeywords { [weak self] (reuslt) in
            guard let this = self else { return }
            switch reuslt {
            case .success:
                this.updateUI()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    override func setupUI() {
        super.setupUI()
        tableView.register(name: "FavoritesCell")
        tableView.register(name: "SearchKeyCell")
        tableView.delegate = self
        tableView.dataSource = self

        searchBar.delegate = self
    }

    func updateUI() {
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellViewModel = viewModel.viewModelForCell(at: indexPath) as? SearchKeyCellViewModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchKeyCell", for: indexPath) as? SearchKeyCell else {
                return UITableViewCell()
            }
            cell.viewModel = cellViewModel
            return cell
        } else if let cellViewModel = viewModel.viewModelForCell(at: indexPath) as? FavoritesCellViewModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell else {
                return UITableViewCell()
            }
            cell.viewModel = cellViewModel
            return cell
        }
        return UITableViewCell()
    }
}
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.loadKeywords(text: searchText) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.updateUI()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.saveKeyword(text: text) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.updateUI()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }
}
