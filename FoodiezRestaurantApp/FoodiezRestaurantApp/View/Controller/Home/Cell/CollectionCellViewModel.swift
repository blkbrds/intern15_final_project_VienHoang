//
//  CollectionCellViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class CollectionCellViewModel {
    
    //MARK: Properties
    var prefix: String = ""
    var name: String = ""
    var suffix: String = ""
    var address: String = ""

    //MARK: Init
    init(menu: Menu) {
        prefix = menu.prefixURLString
        name = menu.name
        suffix = menu.suffix
        address = menu.address
    }
}
