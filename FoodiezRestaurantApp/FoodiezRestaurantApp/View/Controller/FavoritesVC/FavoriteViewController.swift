//
//  FavoriteViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/23/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit
import RealmSwift

final class FavoriteViewController: ViewController {

    //MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    //MARK: - Properties
    private var refreshControl = UIRefreshControl()
    private var cellRegister: String = "FavoritesCell"
    private var notificationToken = NotificationToken()
    var viewModel = FavoriteViewModel()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.setUpObsever()
    }

    override func setupUI() {
        let barButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-deleteAll"), style: .plain, target: self, action: #selector(deleteAllCell))
        navigationItem.rightBarButtonItem = barButtonItem
        let nib = UINib(nibName: App.String.identifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: App.String.identifier)
        tableView.register(name: App.String.favoritesCell)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupData() {
        fetchData()
    }

    @objc private func deleteAllCell() {
        let alertButton = UIAlertAction(title: App.String.yes, style: .default) { [weak self] _ in
            self?.viewModel.removeAllFavorites { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.updateUI()
                case .failure(let error):
                    self.alert(error: error)
                }
            }
        }
        let cancelButton = UIAlertAction(title: App.String.no, style: .cancel, handler: nil)
        let alert = UIAlertController(title: App.String.warning, message: App.String.removeAll, preferredStyle: .alert)
        alert.addAction(alertButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }

    //MARK: Public functions
    func fetchData() {
        viewModel.loadFavorites { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                self.updateUI()
            case .failure(let error):
                self.alert(error: error)
            }
        }
    }

    func updateUI() {
        tableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.favoritesCellViewModell(at: indexPath)
        return cell
    }
}

extension FavoriteViewController: FavoriteViewModelDelegate {
    func viewModel(viewModel: FavoriteViewModel, needperform action: FavoriteViewModel.Action) {
        fetchData()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.handleUnFavorite(at: indexPath) { [weak self] (result) in
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
}
