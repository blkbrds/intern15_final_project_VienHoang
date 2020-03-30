//
//  SearchLoctionTableViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/28/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class SearchLoctionTableViewCell: UITableViewCell {

    //MARK: IBOutlet
    @IBOutlet private weak var imageLocationImageView: UIImageView!
    @IBOutlet private weak var nameLoactionLabel: UILabel!
    
    //MARK: Properties
    var viewModel: SearchLocationViewModel? {
        didSet {
            updateUI()
        }
    }
    
    //MARK: Private functions
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        nameLoactionLabel.text = viewModel.name
        let image = "\(viewModel.prefix)bg_88\(viewModel.suffix)"
        imageLocationImageView.setImage(url: image)
    }
}
