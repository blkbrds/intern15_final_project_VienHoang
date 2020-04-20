//
//  SecondSectionViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 4/16/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class SecondSectionViewModel {

    var nameLocation: String = ""
    var ratingLocation: String = ""

    init(menus: Menu) {
        nameLocation = menus.detailImage?.name ?? ""
        ratingLocation = menus.detailImage?.rating ?? ""
    }
}
