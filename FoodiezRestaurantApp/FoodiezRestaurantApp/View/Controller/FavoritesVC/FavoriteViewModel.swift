//
//  FavoriteViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/23/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class FavoriteViewModel {
    
    //MARK: - Properties
    var menus: [Menu] = []
    
    func numberOfRows(in section: Int) -> Int {
        return menus.count
    }
    
    func favoritesCellViewModell(at indexPath: IndexPath) -> FavoritesCellViewModel {
        return FavoritesCellViewModel(menu: menus[indexPath.row])
    }
}

