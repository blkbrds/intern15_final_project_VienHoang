//
//  FourSectionViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 4/17/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import CoreLocation

final class FourSectionViewModel {
    var menus: Menu
    
    init(menus: Menu = Menu()) {
        self.menus = menus
    }
}
