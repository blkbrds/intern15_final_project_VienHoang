////
////  MapViewModel.swift
////  FoodiezRestaurantApp
////
////  Created by user on 3/5/20.
////  Copyright © 2020 VienH. All rights reserved.
////
//
import Foundation
import CoreLocation

final class MapViewModel {
    var location: CLLocationCoordinate2D?

    init(lag: Double, log: Double) {
        location = CLLocationCoordinate2D(latitude: lag, longitude: log)
    }
}
