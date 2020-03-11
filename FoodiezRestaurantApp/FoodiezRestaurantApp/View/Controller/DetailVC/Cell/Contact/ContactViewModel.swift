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

    init(menu: Menus) {
        nameContact = menu.contact?.name ?? ""
        formattedPhoneContact = menu.contact?.formattedPhone ?? ""
        addressContact = menu.contact?.address ?? ""
        facebookContact = menu.contact?.facebookName ?? ""
        twitter = menu.contact?.twitter ?? ""
    }
}
