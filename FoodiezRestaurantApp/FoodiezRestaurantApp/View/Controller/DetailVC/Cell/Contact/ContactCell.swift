//
//  ContactCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var formattedPhoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var facebookNameLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!


    var viewModel: ContactViewModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        nameLabel.text = viewModel.nameContact
        formattedPhoneLabel.text = viewModel.formattedPhoneContact
        addressLabel.text = viewModel.addressContact
        facebookNameLabel.text = viewModel.facebookContact
        twitterLabel.text = viewModel.twitter
    }
}
