//
//  CollectionViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlet
    @IBOutlet private weak var nameImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    //MARK: - Properties
    var viewModel: CollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    //MARK: - Private functions
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        let image = "\(viewModel.prefix)bg_88\(viewModel.suffix)"
        nameImageView.setImage(url: image)
        addressLabel.text = viewModel.address
    }
}



