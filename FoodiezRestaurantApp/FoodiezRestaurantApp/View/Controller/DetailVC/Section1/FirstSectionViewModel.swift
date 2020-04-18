//
//  FirstSectionViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 4/16/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class FirstSectionViewModel {

    var prefix: String = ""
    var suffix: String = ""
    var userPrefix: String = ""
    var userSuffix: String = ""
    var firstNameUser: String = ""
    var lastNameUser: String = ""

    init(menus: Menu) {
        if let menus = menus.detailImage {
            prefix = menus.prefix
            suffix = menus.suffix
            userPrefix = menus.prefixUser
            userSuffix = menus.suffixUser
            firstNameUser = menus.firstName
            lastNameUser = menus.lastName
        }
    }
}
