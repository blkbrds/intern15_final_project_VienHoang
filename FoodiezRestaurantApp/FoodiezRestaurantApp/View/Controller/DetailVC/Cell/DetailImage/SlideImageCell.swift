//
//  SlideImageCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class SlideImageCell: UITableViewCell {

    //MARK: - Properties
    @IBOutlet private weak var slideImage: UIImageView!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameUserLabel: UILabel!

    var viewModel: SlideImageViewModel? {
        didSet {
            updateUI()
        }
    }

    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
    }

    //MARK: - Public Functions
    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        guard let viewModel = viewModel else { return }
        let image = viewModel.image
        slideImage.setImage(url: image)
        let imageUser = viewModel.imageUser
        userImageView.setImage(url: imageUser)
        nameUserLabel.text = viewModel.nameUserLabel
    }
}
