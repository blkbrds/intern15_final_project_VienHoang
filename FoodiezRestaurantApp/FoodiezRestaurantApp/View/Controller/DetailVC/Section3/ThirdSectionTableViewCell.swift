//
//  ThirdSectionTableViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 4/16/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class ThirdSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var connerView: UIView!
    @IBOutlet weak var addressLabelView: UILabel!
    @IBOutlet private  weak var likeCount: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberLabelView: UILabel!
    
    var viewModel: ThirdSectionViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        connerView.layer.cornerRadius = 30
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        addressLabelView.layer.cornerRadius = 30
        phoneNumberLabelView.layer.cornerRadius = 30
    }
    
    func updateUI() {
        guard let viewModel = viewModel else { return }
        addressLabel.text = viewModel.address
        phoneNumberLabel.text = viewModel.phoneNumber
        likeCount.text = "\(viewModel.like)"
        let descriptionPlace = viewModel.descriptions
               if descriptionPlace != "" {
                descriptionLabel.text = "\(descriptionPlace )"
               } else {
                   descriptionLabel.text = "! ! ! ! Y A Y ! ! ! ! a deviate's guide to the city"
               }
        let phone = viewModel.phoneNumber
        if phone != "" {
            phoneNumberLabel.text = "\(phone)"
        } else {
            phoneNumberLabel.text = "079-911-8690"
        }
    }
}
