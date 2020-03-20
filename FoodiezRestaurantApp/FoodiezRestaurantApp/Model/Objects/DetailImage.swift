//
//  DetailImgae.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import ObjectMapper

final class DetailImage: Mappable {
    
    //MARK: - Properties
    var prefix: String = ""
    var suffix: String = ""
    var nameSource: String = ""
    var userName: String = ""
    var prefixUser: String = ""
    var suffixUser: String = ""
    var lastName: String = ""
    var name: String = ""
    var formattedPhone: String = ""
    var twitter: String = ""
    var facebookName: String = ""
    var rating: String = ""
    var count: String = ""
    var address: String = ""
    var city: String = ""
    var country: String = ""
    var menu: Menu?
    var id: String = ""
    
    init?(map: Map) { }
    
    init() {
    }
    
    //MARK: Public Func
    func mapping(map: Map) {
        id <- map["id"]
        prefix <- map["prefix"]
        suffix <- map["suffix"]
        nameSource <- map["source.name"]
        userName <- map["user.firstName"]
        prefixUser <- map["user.photo.prefix"]
        suffixUser <- map["user.photo.suffix"]
        lastName <- map["user.lastName"]
        name <- map["name"]
        formattedPhone <- map["contact.formattedPhone"]
        twitter <- map["contact.twitter"]
        facebookName <- map["contact.facebookName"]
        rating <- map["rating"]
        count <- map["like.count"]
        address <- map["location.address"]
        city <- map["city"]
        country <- map["country"]
    }
}
