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
    private var cellRegister: String = "CollectionViewCell"
    private var notificationToken = NotificationToken()
    
    var viewModel = FavoriteViewModel()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
