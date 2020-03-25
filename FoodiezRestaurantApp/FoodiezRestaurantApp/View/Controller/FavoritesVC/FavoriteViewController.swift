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
        let nib = UINib(nibName: "FavoritesCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "FavoritesCell")
        tableView.register(name: App.String.favoritesCell)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupData() {
        fetchData()
    }

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
    func viewModel(viewModel: FavoriteViewModel, needperfomAction action: FavoriteViewModel.Action) {
        fetchData()
    }
}
