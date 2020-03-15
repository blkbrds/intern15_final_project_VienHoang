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
    
    //MARK: - Properties
    var name: String = ""
    var lat: String = ""
    var long: String = ""
    var id: String = ""
    var contact: Contact?
    var detailImage: DetailImage?
    var category: JSArray = []
    var prefixCategories = ""
    var suffixCategories = ""
    
    //MARK: - Init
    init?(map: Map) { }
    
    init() { }
    
    //MARK: Public functions
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        lat <- map["location.lat"]
        long <- map["location.long"]
        category <- map["categories"]
        for item in category {
            guard let icon = item["icon"] as? JSObject else { return }
            prefixCategories = (icon["prefix"] as? String)!
            suffixCategories = (icon["suffix"] as? String)!
        }
    }
}
