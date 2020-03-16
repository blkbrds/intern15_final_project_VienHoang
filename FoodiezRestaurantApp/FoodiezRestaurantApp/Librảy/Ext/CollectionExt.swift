//
//  CollectionExt.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/2/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

//MARK: - Extension Collection
extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    var isNotEmpty: Bool {
        return !isEmpty
    }
}

