//
//  SlideImageViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class SlideImageViewModel {

    //MARK: - Properties
    var prefix: String = ""
    var suffix: String = ""
    var userName: String = ""
    var prefixUser: String = ""
    var suffixUser: String = ""
    var lastName: String = ""
    var firstName: String = ""
    var image: String = ""
    var imageUser: String = ""
    var nameUserLabel: String = ""

    //MARK: Init
    init(detailImage: Menu) {
        guard let menu = detailImage.detailImage else { return }
        prefix = menu.prefix
        suffix = menu.suffix
        userName = menu.userName
        prefixUser = menu.prefixUser
        suffixUser = menu.suffixUser
        lastName = menu.lastName
        firstName = menu.userName
        image = "\(prefix)900x600\(suffix)"
        imageUser = "\(prefixUser)50x50\(suffixUser)"
        nameUserLabel = "\(lastName).\(firstName)"
    }
}

