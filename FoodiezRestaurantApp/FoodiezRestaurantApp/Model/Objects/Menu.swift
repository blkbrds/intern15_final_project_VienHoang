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
    var prefixURLString: String = ""
    var suffix: String = ""
    var name: String = ""
    var lat: String = ""
    var long: String = ""
    var detailImage: DetailImage?
    var id: String = ""
    var contact: Contact?
    var address: String = ""
    
    //MARK: - Init
    init?(map: Map) { }

    //MARK: Public functions
    func mapping(map: Map) {
        prefixURLString <- map["icon.prefix"]
        suffix <- map["icon.suffix"]
        name <- map["name"]
        lat <- map["location.lat"]
        long <- map["location.long"]
        id <- map["id"]
        address <- map["location.address"]
    }
}
