//
//  DetailViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/9/20.
//  Copyright © 2020 VienH. All rights reserved.
//
import UIKit

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
    //MARK: - Properties
    var viewModel: DetailViewModel?

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadApi()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        blurViewDetail.layer.cornerRadius = Config.connerBlurView
        
    }

    //MARK: - Life cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
            case.failure(let error):
                self.alert(error: error)
            }
        }
    }

    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        let imageDetail = "\(viewModel.menu?.detailImage?.prefix ?? "")400x800\(viewModel.menu?.detailImage?.suffix ?? "")"
        imageView.setImage(url: imageDetail, defaultImage: #imageLiteral(resourceName: "ic-detail"))
        countryLabel.text = viewModel.menu?.detailImage?.country
        nameLocationLabel.text = viewModel.menu?.detailImage?.name
        twitterLabel.text = viewModel.menu?.detailImage?.twitter
        facebookNameLabel.text = viewModel.menu?.detailImage?.facebookName
        ratingLabel.text = viewModel.menu?.detailImage?.rating
        addressLabel.text = viewModel.menu?.detailImage?.address
        cityLabel.text = viewModel.menu?.detailImage?.city
        formattedPhoneLabel.text = viewModel.menu?.detailImage?.formattedPhone
        nameUserLabel.text = "\(viewModel.menu?.detailImage?.lastName ?? "").\(viewModel.menu?.detailImage?.firstName ?? "")"
        likeCount.text = viewModel.menu?.detailImage?.count
    }
}

//MARK: - Extecion ViewController
extension DetailViewController {
    struct Config {
        static var connerBlurView: CGFloat = 20
        static var connerFavoriesButton: CGFloat = 5
    }
}
