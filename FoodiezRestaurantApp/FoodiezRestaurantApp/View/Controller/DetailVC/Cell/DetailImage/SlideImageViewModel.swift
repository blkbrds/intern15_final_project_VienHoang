//
//  SlideImageViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class SlideImageViewModel {
    var prefix: String = ""
    var suffit: String = ""
    
    init(menu: Menus) {
        prefix = menu.detailImage?.prefix ?? ""
        suffit = menu.detailImage?.suffix ?? ""
    }
}
