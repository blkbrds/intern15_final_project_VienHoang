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
    var detailImage: DetailImage?
    var id: String = ""
    var contact: Contact?
    var category: JSArray = []
    var prefixCategories = ""
    var suffixCategories = ""
    var address: String = ""
    var phoneContact: String = ""
    var twitterContact: String = ""
    var instagramContact: String = ""
    var facebookNameContact: String = ""
    var count: String = ""
    var rating: String = ""

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
        phoneContact <- map["contact.phoneContact"]
        twitterContact <- map["contact.twitterContact"]
        instagramContact <- map["contact.instagramContact"]
        facebookNameContact <- map["contact.facebookNameContact"]
        count <- map["likes.count"]
        rating <- map["likes.rating"]
        
        for item in category {
            guard let icon = item["icon"] as? JSObject else { return }
            prefixCategories = (icon["prefix"] as? String) ?? ""
            suffixCategories = (icon["suffix"] as? String) ?? ""
        }
        id <- map["id"]
        address <- map["location.address"]
    }
}
