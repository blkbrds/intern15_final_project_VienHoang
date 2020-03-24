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
    }

    override func setupUI() {
        tableView.register(name: App.String.favoritesCell)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell else { return UITableViewCell() }
            return cell
        }
        return UITableViewCell()
    }
}
