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

    //MARK: Properties
    var key: String

    //MARK: Init
    init(key: String) {
        self.key = key
    }
}
