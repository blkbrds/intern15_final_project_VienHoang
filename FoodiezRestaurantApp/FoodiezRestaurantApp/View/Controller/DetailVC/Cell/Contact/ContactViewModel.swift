
//
//  ContactViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class ContactViewModel {
    var nameContact: String = ""
    var formattedPhoneContact: String = ""
    var addressContact: String = ""
    var facebookContact: String = ""
    var twitter: String = ""

    init(menu: Menu) {
        guard let menu = menu.contact else { return }
        nameContact = menu.name
        formattedPhoneContact = menu.formattedPhone
        addressContact = menu.address
        facebookContact = menu.facebookName
        twitter = menu.twitter
    }
}
