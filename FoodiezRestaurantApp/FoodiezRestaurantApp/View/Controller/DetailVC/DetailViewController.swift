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
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var blurViewDetail: UIView!
    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var nameLocationLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var formattedPhoneLabel: UILabel!
    @IBOutlet private weak var idFacebook: UILabel!
    @IBOutlet private weak var facebookNameLabel: UILabel!
    @IBOutlet private weak var twitterLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameUserLabel: UILabel!
    @IBOutlet private weak var likeCount: UILabel!
    @IBOutlet private weak var idFacebookLabel: UILabel!

    //MARK: - Properties
    var viewModel: DetailViewModel?

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadApi()
  //      view.isHidden = true
        print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteURL)
    }

    //MARK: - Life cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        fetchDataRealm()
    }

    //MARK: - Public funtions
    func setupNavigation() {
        configFavoriteButton(isFavorite: false)
    }

    func loadApi() {
        fetchData()
    }

    func fetchData() {
        viewModel?.loadApiDetail { [weak self] (reslut) in
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
        guard let viewModel = viewModel else {
            return
        }
        let imageUser = "\(viewModel.menu.detailImage?.prefixUser ?? "")60x60\(viewModel.menu.detailImage?.suffixUser ?? "")"
        userImageView.setImage(url: imageUser)
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        let imageDetail = "\(viewModel.menu.detailImage?.prefix ?? "")400x800\(viewModel.menu.detailImage?.suffix ?? "")"
        let userName = "\(viewModel.menu.detailImage?.firstName ?? "").\(viewModel.menu.detailImage?.lastName ?? ""))"
        nameUserLabel.text = userName
        imageView.setImage(url: imageDetail, defaultImage: #imageLiteral(resourceName: "ic-detail"))
        countryLabel.text = viewModel.menu.detailImage?.country
        let nameLocation = viewModel.menu.detailImage?.name
        if nameLocation != "" {
            nameLocationLabel.text = "\(nameLocation ?? "")"
        } else {
            nameLocationLabel.text = "NhàViên"
        }
        let twitters = viewModel.menu.detailImage?.twitter
        if twitters != "" {
            twitterLabel.text = "\(twitters ?? "")"
        } else {
            twitterLabel.text = "twitterforvien"
        }
        facebookNameLabel.text = viewModel.menu.detailImage?.facebookName
        addressLabel.text = viewModel.menu.detailImage?.address
        cityLabel.text = viewModel.menu.detailImage?.city
        let formattedPhone = viewModel.menu.detailImage?.formattedPhone
        if formattedPhone != "" {
            formattedPhoneLabel.text = "\(formattedPhone ?? "")"
        } else {
            formattedPhoneLabel.text = "\(0799118690)"
        }
        nameUserLabel.text = "\(viewModel.menu.detailImage?.lastName ?? "").\(viewModel.menu.detailImage?.firstName ?? "")"
        likeCount.text = "\(viewModel.menu.detailImage?.count ?? 0)"
        idFacebookLabel.text = viewModel.menu.detailImage?.idFacebook
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
        viewModel?.isFavorites { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                guard let isFavorites = self.viewModel?.menu.isFavorite else { return }
                self.configFavoriteButton(isFavorite: isFavorites)
            case .failure(let error):
                self.alert(error: error)
            }
        }
    }

    func fetchDataRealm() {
        viewModel?.loadFavoritesStatus { [weak self] (isFavorites) in
            guard let self = self else { return }
            self.configFavoriteButton(isFavorite: isFavorites)
        }
    }
}

//MARK: - Extecion ViewController
extension DetailViewController {
    struct Config {
        static var connerBlurView: CGFloat = 20
        static var connerFavoriesButton: CGFloat = 5
    }
}
