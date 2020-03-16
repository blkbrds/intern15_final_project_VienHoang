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
    var suffix: String = ""
    
    init(menu: Menu) {
        guard let menu = menu.detailImage else { return }
        prefix = menu.prefix
        suffix = menu.suffix 
    }
}
