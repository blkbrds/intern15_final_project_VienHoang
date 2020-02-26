//
//  CollectionViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var categoriesNameLabel: UILabel!
    @IBOutlet private weak var countNameLabel: UILabel!

    var viewModel: CollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        let imageName = viewModel.image
        iconImageView.image = UIImage(named: imageName)
        countNameLabel.text = viewModel.count
        categoriesNameLabel.text = viewModel.name
    }
}



