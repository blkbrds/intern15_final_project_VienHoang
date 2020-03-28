//
//  SearchViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/23/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class SearchViewController: ViewController {

    //MARK: Properties
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!

    //MARK: Lyfe cycle
    var viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupData() {
        super.setupData()
        viewModel.displayType = .keyword
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
        tableView.register(name: "SearchKeyCell")
        tableView.register(name: "SearchLoctionTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self

        searchBar.delegate = self
    }

    private func dissmissKeyboard() {
        view.endEditing(true)
    }

    func updateUI() {
        tableView.reloadData()
    }

    func handleSearch() {
        guard let text = searchBar.text else { return }
        viewModel.displayType = .menu
        viewModel.saveKeyword(text: text) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case.success:
                self.updateUI()
            case .failure(let error):
                self.alert(error: error)
            }
        }
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
        } else if let cellViewModel = viewModel.viewModelForCell(at: indexPath) as? SerachLocationViewModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLoctionTableViewCell", for: indexPath) as? SearchLoctionTableViewCell else {
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
    
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath) as? SearchKeyCell) != nil {
            searchBar.text = viewModel.getKeyword(at: indexPath)
            handleSearch()
        } else if (tableView.cellForRow(at: indexPath) as? SearchLoctionTableViewCell) != nil {
            let vc = DetailViewController()
            vc.viewModel = viewModel.viewModelForDetail(at: indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }
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
        handleSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        setupData()
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dissmissKeyboard()
    }
}
