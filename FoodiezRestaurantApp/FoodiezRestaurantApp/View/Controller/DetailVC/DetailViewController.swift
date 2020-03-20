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
    //MARK: - Properties
    var viewModel = DetailViewModel()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        blurViewDetail.layer.cornerRadius = 20
        addFavoritesButton.layer.cornerRadius = 5
    }
    
    //MARK: - Life cucle
      override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
      }
}

extension DetailViewController {
    func setStatusBarStyle(_ style: UIStatusBarStyle) {
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusBar.backgroundColor = style == .lightContent ? UIColor.black : .white
            statusBar.setValue(style == .lightContent ? UIColor.white : .black, forKey: "foregroundColor")
        }
    }
}

