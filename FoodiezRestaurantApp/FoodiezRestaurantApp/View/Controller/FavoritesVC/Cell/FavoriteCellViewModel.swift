//
//  FavoriteCellViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/24/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class FavoritesCellViewModel {
    var nameLacation: String = ""
    var addressLocation: String = ""
    var phoneNumberLocation: String = ""
    var imageLocation: String = ""
    
    init(menu: Menu) {
        nameLacation = menu.detailImage?.name ?? ""
        addressLocation = menu.detailImage?.address ?? ""
        phoneNumberLocation = menu.detailImage?.formattedPhone ?? ""
        imageLocation = "\(menu.detailImage?.prefix ?? "")80x100\(menu.detailImage?.suffix ?? "")"
    }
}
