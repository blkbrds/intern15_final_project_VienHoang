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
    var location: CLLocationCoordinate2D?
    var latLocation: Double = 0
    var longLocation: Double = 0
    
    init(menus: Menu) {
        latLocation = menus.detailImage?.lat ?? 0
        longLocation = menus.detailImage?.long ?? 0
    }
}
