//
//  Categories.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import ObjectMapper
final class Menu: Mappable {
    
    var prefixURLString: String = ""
    var suffix: String = ""
    var name: String = ""
    var lat: String = ""
    var long: String = ""
    var id: String = ""
    var contact: Contact?
    var detailImage: DetailImage?
    
    init?(map: Map) { }

    func mapping(map: Map) {
        prefixURLString <- map["icon.prefix"]
        suffix <- map["icon.suffix"]
        name <- map["name"]
        lat <- map["location.lat"]
        long <- map["location.long"]
        id <- map["id"]
    }
}
