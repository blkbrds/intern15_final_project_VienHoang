//
//  Keyword.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers final class Keyword: Object {
    dynamic var keyword: String = ""
    dynamic var searchTime: Date = Date()

    init(keyword: String, searchTime: Date) {
        self.keyword = keyword
        self.searchTime = searchTime
    }

    required init() { }

    override static func primaryKey() -> String? {
      return "keyword"
    }
}
