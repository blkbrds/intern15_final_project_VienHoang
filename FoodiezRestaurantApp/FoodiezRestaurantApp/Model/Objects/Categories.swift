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
    var prefixURL: String = ""
    var suffixURL: String = ""
    var countURL: String = ""
    var nameURL: String = ""
    var shortName: String = ""

    init?(map: Map) { }

    func mapping(map: Map) {
        prefixURL <- map["icon.prefix"]
        suffixURL <- map["icon.suffix"]
        nameURL <- map["name"]
        shortName <- map["shortName"]
    }
}
