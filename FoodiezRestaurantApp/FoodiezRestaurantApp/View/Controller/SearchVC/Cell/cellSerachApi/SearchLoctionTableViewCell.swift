//
//  SearchLoctionTableViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/28/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

class SearchLoctionTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLocationImageView: UIImageView!
    @IBOutlet weak var nameLoactionLabel: UILabel!
    
    var viewModel: SerachLocationViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        nameLoactionLabel.text = viewModel.name
        let image = "\(viewModel.prefix)bg_88\(viewModel.suffix)"
        imageLocationImageView.setImage(url: image)
    }
}
