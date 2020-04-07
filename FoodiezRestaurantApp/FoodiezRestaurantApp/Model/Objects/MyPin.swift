//
//  Stadium.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/5/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import MapKit

final class MyPin {

    //MARk: - Properties
    var title: String?
    var locationName: String?
    var location: CLLocationCoordinate2D?
    var country: String?
    var id: String?
    var prefix: String?

    //MARK: - Init
    init(json: JSON) {
        if let location = json["location"] as? [String: Any],
            let lat = location["lat"] as? Double,
            let long = location["long"] as? Double,
            let lng = location["lng"] as? Double,
            let country = location["location"] as? String {
            self.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            self.country = country
        }
        if let categories = json["categories"] as? JSArray {
            for item in categories {
                guard let icon = item["icon"] as? JSObject else { return }
                prefix = (icon["prefix"] as? String)
            }
        }
        locationName = json["name"] as? String
        id = json["id"] as? String
    }
}

extension MyPin: Equatable {
    static func == (lhs: MyPin, rhs: MyPin) -> Bool {
        return lhs.id == rhs.id
    }
}

class PlaceManager {
    static var shared: PlaceManager = PlaceManager()
    var places: [Menu] = []
    private init() { }
}
