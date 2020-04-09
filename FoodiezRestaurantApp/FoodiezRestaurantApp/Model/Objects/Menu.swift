//
//  Categories.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import MapKit

final class Menu: Object, Mappable {

    //MARK: - Properties
    @objc dynamic var id: String = ""
    var name: String = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    @objc dynamic var detailImage: VenuesDetail?
    var category: JSArray = []
    var prefixCategories = ""
    var suffixCategories = ""
    var address: String = ""
    var distance: String = ""
    var prefixThumbnail: String = ""
    var suffixThumbnail: String = ""
    @objc dynamic var isFavorite: Bool = false
    var placeImage: String?
    var locationCoordinate: CLLocationCoordinate2D?
    

    //MARK: - Init
    init?(map: Map) { }
    
    required init() { }

    struct GoogleApiResult {
        var places: [Menu]
    }

    //MARK: Public functions
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        lat <- map["location.lat"]
        long <- map["location.lng"]
        locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        category <- map["categories"]
        for item in category {
            guard let icon = item["icon"] as? JSObject else { return }
            prefixCategories = (icon["prefix"] as? String) ?? ""
            suffixCategories = (icon["suffix"] as? String) ?? ""
        }
        address <- map["location.address"]
        var items: JSArray = []
        items <- map["items"]
        for item in items {
            guard let prefix = item["prefix"] as? String else { return }
            prefixThumbnail = prefix
            
            guard let suffix = item["suffix"] as? String else { return }
            suffixThumbnail = suffix
        }
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    override class func ignoredProperties() -> [String] {
        return ["name", "lat", "long", "tagcategorys", "prefixCategories", "suffixCategories", "address", "distance", "rating", "image"]
    }
}
