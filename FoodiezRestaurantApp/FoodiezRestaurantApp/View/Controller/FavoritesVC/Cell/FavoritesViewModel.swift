//
//  FavoritesViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/24/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class FavoritesCellViewModel {
    var nameLocation: String = ""
    var addressLacation: String = ""
    var phoneLocation: String = ""
    var locationImage: String = ""

    init(menu: Menu) {
        self.nameLocation = menu.detailImage?.name ?? ""
        self.addressLacation = menu.detailImage?.address ?? ""
        self.phoneLocation = menu.detailImage?.formattedPhone ?? ""
        self.locationImage = "\(menu.detailImage?.prefix ?? "")80x100\(menu.detailImage?.suffix ?? "")"

    }
}
