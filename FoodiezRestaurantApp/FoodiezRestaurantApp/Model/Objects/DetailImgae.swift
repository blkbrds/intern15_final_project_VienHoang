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
    
    init?(map: Map) { }
    
    func mapping(map: Map) {
        prefix <- map["prefix"]
        suffix <- map["suffix"]
    }
}
