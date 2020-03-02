//
//  CollectionCellViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class CollectionCellViewModel {
    var imageName: String
    var name: String
    var count: String

    init(category: Categories) {
        imageName = category.imageURLString
        name = category.nameImageURL
        count = category.countURL
    }
}
