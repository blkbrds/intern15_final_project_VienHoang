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
        prefix = menu.detailImage?.prefix ?? ""
        suffix = menu.detailImage?.suffix ?? ""
        userName = menu.detailImage?.userName ?? ""
        prefixUser = menu.detailImage?.prefixUser ?? ""
        suffitUser = menu.detailImage?.suffixUser ?? ""
        lastName = menu.detailImage?.lastName ?? ""
        firstName = menu.detailImage?.userName ?? ""
    }
}
