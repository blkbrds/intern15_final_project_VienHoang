//
//  SearchKeyCellViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

protocol SearchCellViewModel { }

final class SearchKeyCellViewModel: SearchCellViewModel {
    var key: String

    init(key: String) {
        self.key = key
    }
}
