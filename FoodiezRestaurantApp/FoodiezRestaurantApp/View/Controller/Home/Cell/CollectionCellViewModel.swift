//
//  CollectionCellViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class CollectionCellViewModel {
    var prefix: String
    var name: String = ""
    var suffix: String

    init(menu: Menus) {
        prefix = menu.prefixURLString
        name = menu.name
        suffix = menu.suffix
    }
}
