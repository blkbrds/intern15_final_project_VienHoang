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
    
    init?(map: Map) { }
    
    init() {
    }
    
    func mapping(map: Map) {
        prefix <- map["prefix"]
        suffix <- map["suffix"]
        nameSource <- map["source.name"]
        userName <- map["user.firstName"]
        prefixUser <- map["user.photo.prefix"]
        suffixUser <- map["user.photo.suffix"]
        lastName <- map["user.lastName"]
    }
}
