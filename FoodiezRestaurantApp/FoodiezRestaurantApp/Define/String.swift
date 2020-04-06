//
//  App.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//
import Foundation

extension App {

    /**
     This file defines all localizable strings which are used in this application.
     Please localize defined strings in `Resources/Localizable.strings`.
     */

    struct String { }
    struct Identifier { }
    struct Home { }
}
extension App.String {
    static let clientID = "YFZVFSOQIN043IXQOKIXVU5X0GHRBHIJFHQLTFR31XHPX4Y5"
    static let clientSecret = "3BK3KV0LYKRO0SK5EZXI5SLPDY4ZUY21O22R3TZ3ISYTVOCO"
    static let ll = "40.7,-74"
    static let v = "20162504"
    static let yes = "yes"
    static let no = "no"
    static let warning = "warning"
    static let removeAll = "Do you want delete all?"
}

extension App.Identifier {
    static let slideImageCell = "SlideImageCell"
    static let favoritesCell = "FavoritesCell"
    static let searchKeyCell = "SearchKeyCell"
    static let searchLocationTableViewCell = "SearchLocationTableViewCell"
    static let collectionViewCell = "CollectionViewCell"
}

extension App.Home {
    static var alertMessage: String { return "Do you want to delete?".localized()}
    static var alertTitle: String { return "".localized()}
}
