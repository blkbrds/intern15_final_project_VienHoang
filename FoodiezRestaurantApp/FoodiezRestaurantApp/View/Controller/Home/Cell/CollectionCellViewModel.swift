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
    var name: String
    var suffix: String
    var shortName: String
    var count: String

    init(category: Categories) {
        prefix = category.prefixURLString
        name = category.name
        suffix = category.suffix
        shortName = category.shortName
        count = category.count
    }
}
