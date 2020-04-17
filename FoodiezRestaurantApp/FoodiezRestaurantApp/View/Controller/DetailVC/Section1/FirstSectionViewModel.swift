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
        prefix = menus.detailImage?.prefix ?? ""
        suffix = menus.detailImage?.suffix ?? ""
        userPrefix = menus.detailImage?.prefixUser ?? ""
        userSuffix = menus.detailImage?.suffixUser ?? ""
        firstNameUser = menus.detailImage?.firstName ?? ""
        lastNameUser = menus.detailImage?.lastName ?? ""
    }
}
