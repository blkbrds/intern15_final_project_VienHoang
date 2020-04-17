//
//  FirstSectionTableViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 4/16/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

class FirstSectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var connerView: UIView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var locationImageView: UIImageView!
    
    var viewModel: FirstSectionViewModel? {
        didSet {
            updateUI()
        }
}
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = 40
        locationImageView.layer.cornerRadius = 30
         contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func updateUI() {
        guard let viewModel = viewModel else {return}
        let image = "\(viewModel.prefix)320x134\(viewModel.suffix)"
        let imageUser = "\(viewModel.userPrefix)80x80\(viewModel.userSuffix)"
        locationImageView.setImage(url: image)
        userNameLabel.text = "\(viewModel.firstNameUser)\(viewModel.lastNameUser)"
        userImageView.setImage(url: imageUser)
    }
}
