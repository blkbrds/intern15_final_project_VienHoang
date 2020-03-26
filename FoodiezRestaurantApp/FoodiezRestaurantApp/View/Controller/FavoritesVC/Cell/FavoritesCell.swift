//
//  FavoritesTableViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/24/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class FavoritesCell: UITableViewCell {

    //MARK: - Properties
    @IBOutlet private weak var likeCountLocatinLabel: UILabel!
    @IBOutlet private weak var nameLocationLabel: UILabel!
    @IBOutlet private weak var locationImageView: UIImageView!
    @IBOutlet private weak var addressLabel: UILabel!
    
    var viewModel: FavoritesCellViewModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        if let viewModel = viewModel {
            likeCountLocatinLabel.text = "\(viewModel.likeCountLocation)"
            addressLabel.text = viewModel.addressLocation
            nameLocationLabel.text = viewModel.nameLacation
            locationImageView.setImage(url: viewModel.imageLocation, defaultImage: #imageLiteral(resourceName: "icons8-user-60"))
        }
    }
}
