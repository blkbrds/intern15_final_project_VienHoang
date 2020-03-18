
//
//  ContactViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class ContactViewModel {

    //MARK: - Properties
    var nameContact: String = ""
    var stateContact: String = ""
    var countryContact: String = ""
    var cityContact: String = ""
    var distanceContact: String = ""

    //MARK: - Init
    init(menu: Menu) {
        guard let menu = menu.contact else { return }
        nameContact = menu.name
        stateContact = menu.formattedPhone
        countryContact = menu.address
        cityContact = menu.facebookName
        distanceContact = menu.twitter
    }
}
