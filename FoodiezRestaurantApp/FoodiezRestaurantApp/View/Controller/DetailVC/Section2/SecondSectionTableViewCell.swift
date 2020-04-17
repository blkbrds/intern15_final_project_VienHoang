//
//  SecondSectionTableViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 4/16/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class SecondSectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var connerView: UIView!
    @IBOutlet private weak var nameLocationLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!

    var viewModel: SecondSectionViewModel? {
        didSet {
            updateUI()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        connerView.layer.cornerRadius = 30
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }

    func updateUI() {
        guard let viewModel = viewModel else { return }
        nameLocationLabel.text = viewModel.nameLocation
        ratingLabel.text = viewModel.ratingLocation
    }
}
