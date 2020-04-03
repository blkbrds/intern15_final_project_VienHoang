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
import GoogleMaps

struct Position {
       var lat: CLLocationDegrees = 0
     var long: CLLocationDegrees = 0
}

final class Menu: Object, Mappable {

    //MARK: - Properties
    @objc dynamic var id: String = ""
    var name: String = ""
    @objc dynamic var detailImage: DetailImage?
    var category: JSArray = []
    var prefixCategories = ""
    var suffixCategories = ""
    var address: String = ""
    var distance: String = ""
    var prefixThumnail: String = ""
    var suffixThumnail: String = ""
    @objc dynamic var isFavorite: Bool = false
    var image: String?
    var position = Position()

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
        category <- map["categories"]
        position.lat <- map["location.lat"]
        position.long <- map["location.long"]
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
            self.prefixThumnail = prefix

            guard let suffix = item["suffix"] as? String else { return }
            self.suffixThumnail = suffix
        }
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    override class func ignoredProperties() -> [String] {
        return ["name", "lat", "long", "tagcategorys", "prefixCategories", "suffixCategories", "address", "distance", "rating", "image"]
    }
}
