//
//  SearchLocationTableViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/28/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class SearchLocationTableViewCell: UITableViewCell {

    //MARK: IBOutlet
    @IBOutlet private weak var imageLocationImageView: UIImageView!
    @IBOutlet private weak var nameLocationLabel: UILabel!
    
    //MARK: Properties
    var viewModel: SearchLocationViewModel? {
        didSet {
            updateUI()
        }
    }
    
    //MARK: Private functions
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        nameLocationLabel.text = viewModel.name
        let image = "\(viewModel.prefix)bg_88\(viewModel.suffix)"
        imageLocationImageView.setImage(url: image)
    }
}
