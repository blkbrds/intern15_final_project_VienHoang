//
//  FavoriteCellViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/24/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class FavoritesCellViewModel: SearchCellViewModel {
    var nameLacation: String = ""
    var addressLocation: String = ""
    var imageLocation: String = ""
    var likeCountLocation: Int = 0
    
    init(menu: Menu) {
        nameLacation = menu.detailImage?.name ?? ""
        addressLocation = menu.detailImage?.address ?? ""
        imageLocation = "\(menu.detailImage?.prefix ?? "")100x80\(menu.detailImage?.suffix ?? "")"
        likeCountLocation = menu.detailImage?.count ?? 0
    }
}
