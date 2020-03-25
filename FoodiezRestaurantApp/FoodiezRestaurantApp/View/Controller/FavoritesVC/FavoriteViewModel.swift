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
    var menu: [Menu] = []
    
    func numberOfRowsInSection(section: Int) -> Int {
        return menu.count
    }
    
    func favoritesCellViewModell(at indexPath: IndexPath) -> FavoritesCellViewModel {
        return FavoritesCellViewModel(menu: menu[indexPath.row])
    }
}

