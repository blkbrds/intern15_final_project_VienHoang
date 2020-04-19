//
//  DetailViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/9/20.
//  Copyright © 2020 VienH. All rights reserved.
//
import UIKit
import RealmSwift

final class DetailViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet private weak var imageView: UIImageView!
    //MARK: - Properties
    var viewModel = DetailViewModel()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadApi()
        setupUI()
//        self.imageView.image = #imageLiteral(resourceName: "hinhnen")
        print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteURL)
        title = "Detail"
        //       tableView.backgroundView = UIImageView(image: UIImage(named: "ic-detail"))
    }

    //MARK: - Life cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
        fetchDataRealm()
    }


    func setupUI() {
        tableView.register(name: "FirstSectionTableViewCell")
        tableView.register(name: "SecondSectionTableViewCell")
        tableView.register(name: "ThirdSectionTableViewCell")
        tableView.register(name: "FourSectionTableViewCell")

        tableView.delegate = self
        tableView.dataSource = self
    }

    //MARK: - Public funtions
    func setupNavigation() {
        configFavoriteButton(isFavorite: false)
    }

    func loadApi() {
        fetchData()
    }

    func fetchData() {
        HUD.show()
        viewModel.loadApiDetail { [weak self] (reslut) in
            HUD.popActivity()
            guard let self = self else { return }
            switch reslut {
            case .success:
                self.updateUI()
                self.fetchDataRealm()
            case.failure(let error):
                self.alert(error: error)
            }
        }
    }

    func updateUI() {
        tableView.reloadData()
    }

    func configFavoriteButton(isFavorite: Bool) {
        var color: UIColor?
        if isFavorite {
            color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        } else {
            color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        let favoriteButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-love-31"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        navigationItem.rightBarButtonItem = favoriteButtonItem
        favoriteButtonItem.tintColor = color
    }

    @objc func handleFavoriteButton() {
        viewModel.isFavorites { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                let isFavorites = self.viewModel.menu.isFavorite
                self.configFavoriteButton(isFavorite: isFavorites)
            case .failure(let error):
                self.alert(error: error)
            }
        }
    }

    func fetchDataRealm() {
        viewModel.loadFavoritesStatus { [weak self] (isFavorites) in
            guard let self = self else { return }
            self.configFavoriteButton(isFavorite: isFavorites)
        }
    }
}

extension DetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItime(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = DetailViewModel.SectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch type {
        case .firstSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstSectionTableViewCell", for: indexPath) as? FirstSectionTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.firstSectionForCell()
            return cell
        case .secondSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondSectionTableViewCell", for: indexPath) as? SecondSectionTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.secondSectionCellForCell()
            return cell
        case .thirdSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdSectionTableViewCell", for: indexPath) as? ThirdSectionTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.thirdSectionForCell()
            return cell
        case .fourSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FourSectionTableViewCell", for: indexPath) as? FourSectionTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.fourSectionForCell()
            return cell
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


//MARK: - Extecion ViewController
extension DetailViewController {
    struct Config {
        static var connerBlurView: CGFloat = 20
        static var connerFavoriesButton: CGFloat = 5
    }
}
