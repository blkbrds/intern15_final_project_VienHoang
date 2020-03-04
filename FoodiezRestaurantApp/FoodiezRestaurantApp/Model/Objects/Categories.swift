//
//  Categories.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import ObjectMapper
final class Categories: Mappable {
    var prefixURLString: String = ""
    var suffix: String = ""
    var count: String = ""
    var name: String = ""
    var shortName: String = ""

    init?(map: Map) { }

    func mapping(map: Map) {
        prefixURLString <- map["icon.prefix"]
        suffix <- map["icon.suffix"]
        name <- map["name"]
        shortName <- map["shortName"]
    }
}
