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
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var twitterLabel: UILabel!
    @IBOutlet private weak var instagramLabel: UILabel!
    @IBOutlet private weak var facebookNameLabel: UILabel!
    @IBOutlet private weak var likeCountLabel: UILabel!

    //MARK: Properties
    var viewModel: ContactViewModel? {
        didSet {
            updateUI()
        }
    }

    //MARK: - Public functions
    func updateUI() {
        guard let viewModel = viewModel else { return }
        phoneLabel.text = viewModel.nameContact
        twitterLabel.text = viewModel.stateContact
        instagramLabel.text = viewModel.countryContact
        facebookNameLabel.text = viewModel.cityContact
        twitterLabel.text = viewModel.distanceContact
    }
}
