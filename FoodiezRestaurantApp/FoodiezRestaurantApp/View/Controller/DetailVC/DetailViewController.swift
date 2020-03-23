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
//    var isCouponFav = UserDefaults.standard.bool(forKey: "isCouponFav")

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadApi()
//        setupUI()
        print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteURL)
    }

//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        blurViewDetail.layer.cornerRadius = Config.connerBlurView
//
//    }

    //MARK: - Life cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataRealm()
    }
    
    func setupUI() {
//        handleFavoritesButton()
        configFavoritesCustom(isFavorites: false, sender: nil)
    }

    //MARK: - Public functions
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
        ratingLabel.text = viewModel.menu.detailImage?.rating
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

    @IBAction func favButtonTapped(sender: UIButton) {
        guard let viewModel = viewModel?.menu.isFavorite else {
            return
        }
        configFavoritesCustom(isFavorites: viewModel, sender: sender)
    }

    func configFavoritesCustom(isFavorites: Bool, sender: UIButton?) {
        var imgae: UIImage?
        if !isFavorites {
            imgae = #imageLiteral(resourceName: "icons8-love-32")
        } else {
            imgae = #imageLiteral(resourceName: "icons8-love-31")
        }
//        isCouponFav = !isCouponFav
        guard let sender = sender else {
            return
        }
        sender.setImage(imgae, for: .normal)
//        UserDefaults.standard.set(isFavorites, forKey: "isCouponFav")
//        UserDefaults.standard.synchronize()
        handleFavoritesButton()
    }

    func handleFavoritesButton() {
        viewModel?.isFavorites { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                guard let isFavorites = self.viewModel?.menu.isFavorite else { return }
                self.configFavoritesCustom(isFavorites: isFavorites, sender: nil)
            case .failure(let error):
                self.alert(error: error)
            }
        }
    }

    func fetchDataRealm() {
        viewModel?.loadFavoritesStatus { [weak self] (isFavorites) in
            guard let self = self else { return }
            self.configFavoritesCustom(isFavorites: isFavorites, sender: nil)
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
