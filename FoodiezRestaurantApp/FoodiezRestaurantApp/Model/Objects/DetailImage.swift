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
    var firstName: String = ""
    var prefixUser: String = ""
    var suffixUser: String = ""
    var lastName: String = ""
    var name: String = ""
    var formattedPhone: String = ""
    var twitter: String = ""
    var facebookName: String = ""
    var rating: String = ""
    var count: Int = 0
    var address: String = ""
    var city: String = ""
    var country: String = ""
    var id: String = ""
    var groups: JSArray = []
    var idFacebook: String = ""
    
    //MARK: - Init
    init?(map: Map) { }

    init() { }

    //MARK: Public Func
    func mapping(map: Map) {
        id <- map["id"]
        nameSource <- map["source.name"]
        name <- map["name"]
        formattedPhone <- map["contact.formattedPhone"]
        twitter <- map["contact.twitter"]
        facebookName <- map["contact.facebookName"]
        rating <- map["rating"]
        count <- map["likes.count"]
        address <- map["location.address"]
        city <- map["city"]
        country <- map["country"]
        groups <- map["photos.groups"]
        idFacebook <- map["contact.facebook"]
        var array: JSArray = []
        for index in groups {
            guard let items = index["items"] as? JSArray else { return }
            array = items
        }
        for item in array {
            guard let prefix = item["prefix"] as? String else { return }
            self.prefix = prefix
            guard let suffix = item["suffix"] as? String else { return }
            self.suffix = suffix
            firstName <- map["user.firstName"]
            if let user = item["user"] as? JSObject, let firstName = user["firstName"] as? String, let lastName = user["user.lastName"] as? String, let photo = user["photo"] as? JSObject, let prefixUser = photo["prefixUser"] as? String, let suffixUser = photo["suffixUser"] as? String {
                self.firstName = firstName
                self.lastName = lastName
                self.prefixUser = prefixUser
                self.suffixUser = suffixUser
            }
        }
    }
}
