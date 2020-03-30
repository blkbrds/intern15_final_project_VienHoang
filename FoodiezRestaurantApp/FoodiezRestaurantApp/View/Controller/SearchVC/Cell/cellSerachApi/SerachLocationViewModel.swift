//
//  SerachLocationViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/28/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class SerachLocationViewModel: SearchCellViewModel {
    
    //MARK: Properties
    var prefix: String = ""
    var name: String = ""
    var suffix: String = ""

    //MARK: Init
    init(menu: Menu) {
        prefix = menu.prefixCategories
        name = menu.name
        suffix = menu.suffixCategories
    }
}
