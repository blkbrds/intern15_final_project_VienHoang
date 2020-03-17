//
//  Stadium.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/5/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import MapKit

final class MyPin: NSObject, MKAnnotation {
    
    //MARk: - Properties
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    //MARK: - Init
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    //MARK: - Properties
    var subtitle: String? {
        return locationName
    }
}


