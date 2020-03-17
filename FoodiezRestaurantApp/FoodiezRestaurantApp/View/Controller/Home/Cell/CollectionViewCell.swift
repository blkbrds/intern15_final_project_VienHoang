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
    @IBOutlet private weak var addressLabel: UILabel!

    //MARK: - Properties
    var viewModel: CollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }

    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        nameImageView.layer.cornerRadius = nameImageView.frame.width / 2
        backgroundColor = .clear
        layer.masksToBounds = true
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        contentView.backgroundColor = UIColor(displayP3Red: 83 / 255, green: 27 / 255, blue: 220 / 255, alpha: 0.5)
        contentView.layer.cornerRadius = 40
    }

    //MARK: - Private functions
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        let image = "\(prefix)bg_88\(suffix)"
        nameImageView.setImage(url: image)
        addressLabel.text = viewModel.address
    }
}



