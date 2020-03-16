//
//  SlideImageCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class SlideImageCell: UITableViewCell {

    @IBOutlet private weak var slideImage: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameUserLabel: UILabel!
    var viewModel: SlideImageViewModel? {
        didSet {
            updateUI()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
    }
    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        let image = "\(viewModel.prefix)900x600\(viewModel.suffix)"
        slideImage.setImage(url: image)
        let imageUser = "\(viewModel.prefixUser)50x50\(viewModel.suffitUser)"
        userImageView.setImage(url: imageUser)
        nameUserLabel.text = "\(viewModel.lastName).\(viewModel.firstName)"
    }
}
