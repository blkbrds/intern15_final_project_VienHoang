//
//  SlideImageViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class SlideImageViewModel {
    var prefix: String = ""
    var suffix: String = ""
    var userName: String = ""
    var prefixUser: String = ""
    var suffitUser: String = ""
    var lastName: String = ""
    var firstName: String = ""
    
    init(menu: Menu) {
        guard let menu = menu.detailImage else { return }
        prefix = menu.prefix
        suffix = menu.suffix
        userName = menu.userName
        prefixUser = menu.prefixUser
        suffitUser = menu.suffixUser
        lastName = menu.lastName
        firstName = menu.userName
    }
}
