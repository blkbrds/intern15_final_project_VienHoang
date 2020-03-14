//
//  ContactCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class ContactCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var formattedPhoneLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var facebookNameLabel: UILabel!
    @IBOutlet private weak var twitterLabel: UILabel!

    //MARK: Properties
    var viewModel: ContactViewModel? {
        didSet {
            updateUI()
        }
    }

    //MARK: - Public functions
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
