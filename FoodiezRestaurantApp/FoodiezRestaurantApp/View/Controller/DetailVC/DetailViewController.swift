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
    @IBOutlet private weak var blurViewDetail: UIView!
    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var addFavoritesButton: UIButton!
    @IBOutlet private weak var nameLocationLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var formattedPhoneLabel: UILabel!
    @IBOutlet private weak var facebookNameLabel: UILabel!
    @IBOutlet private weak var twitterLabel: UILabel!

    //MARK: - Properties
    var viewModel: DetailViewModel?

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadApi()
        blurViewDetail.layer.cornerRadius = Config.connerBlurView
        addFavoritesButton.layer.cornerRadius = Config.connerFavoriesButton
    }

    //MARK: - Life cucle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK: - Public funtions
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
        countryLabel.text = viewModel.menu?.detailImage?.country
        nameLocationLabel.text = viewModel.menu?.detailImage?.name
        twitterLabel.text = viewModel.menu?.detailImage?.twitter
        facebookNameLabel.text = viewModel.menu?.detailImage?.facebookName
        ratingLabel.text = viewModel.menu?.detailImage?.rating
        addressLabel.text = viewModel.menu?.detailImage?.address
        cityLabel.text = viewModel.menu?.detailImage?.city
        formattedPhoneLabel.text = viewModel.menu?.detailImage?.formattedPhone
    }
}

//MARK: - Extecion DetailViewController
extension DetailViewController {
    struct Config {
        static var connerBlurView: CGFloat = 20
        static var connerFavoriesButton: CGFloat = 5
    }
}
