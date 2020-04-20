//
//  ThirdSectionViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 4/16/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class ThirdSectionViewModel {
    var address = ""
    var phoneNumber = ""
    var like = 0
    var descriptions = ""
    
    init(menus: Menu) {
        address = menus.detailImage?.address ?? ""
        phoneNumber = menus.detailImage?.formattedPhone ?? ""
        like = menus.detailImage?.count ?? 0
        descriptions = menus.detailImage?.descriptionLocation ?? ""
    }
}
