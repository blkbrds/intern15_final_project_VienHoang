//
//  DetailImgae.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

final class DetailImage: Object, Mappable {

    //MARK: - Properties
    @objc dynamic var prefix: String = ""
    @objc dynamic var suffix: String = ""
    var nameSource: String = ""
    var firstName: String = ""
    var prefixUser: String = ""
    var suffixUser: String = ""
    var lastName: String = ""
    @objc dynamic var name: String = ""
    var formattedPhone: String = ""
    var twitter: String = ""
    var facebookName: String = ""
    @objc dynamic var rating: String = ""
    var count: Int = 0
    @objc dynamic var address: String = ""
    var city: String = ""
    var country: String = ""
    @objc dynamic var id: String = ""
    var groups: JSArray = []
    var idFacebook: String = ""

    //MARK: - Init
    init?(map: Map) { }

    required init() { }

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
            guard let user = item["user"] as? JSObject else {
                return
            }
            guard let lastName = user["lastName"] as? String, let firstName = user["firstName"] as? String else { return }
            self.lastName = lastName
            self.firstName = firstName
            guard let photo = user["photo"] as? JSObject else { return }
            if let prefixUser = photo["prefix"] as? String {
                self.prefixUser = prefixUser
            } else {
                self.prefixUser = ""
            }
            if let suffixUser = photo["suffix"] as? String {
                self.suffixUser = suffixUser
            } else {
                self.suffixUser = ""
            }
        }
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    override class func ignoredProperties() -> [String] {
        return ["nameSource", "firstName", "prefixUser", "suffixUser", "lastName", "formattedPhone", "twitter", "facebookName", "count", "city", "country", "groups", "idFacebook"]
    }
}


