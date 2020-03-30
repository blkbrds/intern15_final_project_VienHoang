//
//  SearchKeyCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class SearchKeyCell: UITableViewCell {

    //MARK: IBOutlet
    @IBOutlet private weak var keyLabel: UILabel!

    //MARK: Properties
    var viewModel: SearchKeyCellViewModel? {
        didSet {
            updateUI()
        }
    }

    //MARK: Private functions
    private func updateUI() {
        keyLabel.text = viewModel?.key
    }
}
