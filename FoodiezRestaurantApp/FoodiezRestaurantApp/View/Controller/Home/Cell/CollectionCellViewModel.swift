//
//  CollectionCellViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class CollectionCellViewModel {
    var image: String
    var name: String
    var count: String
    
    init(category: Categories) {
        image = category.imageURL
        name = category.nameImageURL
        count = category.countURL
    }
}
