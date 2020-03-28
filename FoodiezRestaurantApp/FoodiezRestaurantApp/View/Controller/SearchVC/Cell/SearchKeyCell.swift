//
//  SearchKeyCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

class SearchKeyCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!

    var viewModel: SearchKeyCellViewModel? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        self.keyLabel.text = viewModel?.key
    }

    
}
