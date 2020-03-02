//
//  CollectionViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var nameImageView: UIImageView!
    @IBOutlet private weak var shortNameLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!

    var viewModel: CollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        shortNameLabel.text = viewModel.shortName
        nameLabel.text = viewModel.name
        let image = "\(viewModel.prefix)bg_88\(viewModel.suffix)"
        nameImageView.setImage(url: image)
    }
}



