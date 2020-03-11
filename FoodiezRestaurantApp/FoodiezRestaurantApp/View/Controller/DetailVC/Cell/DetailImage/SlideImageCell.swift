//
//  SlideImageCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

class SlideImageCell: UITableViewCell {

    @IBOutlet weak var slideImage: UIImageView!
    
    var viewModel: SlideImageViewModel? {
        didSet {
            updateUI()
        }
    }
    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        let image = "\(viewModel.prefix)900x600\(viewModel.suffit)"
        slideImage.image = UIImage(named: image)
    }
}