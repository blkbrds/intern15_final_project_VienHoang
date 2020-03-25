//
//  FavoriteViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/23/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import RealmSwift

final class FavoriteViewModel {

    //MARK: - Properties
    var menus: [Menu] = []

    func numberOfRows(in section: Int) -> Int {
        return menus.count
    }

    func loadFavorites(completion: RealmCompletion) {
        do {
            let realm = try Realm()
            let objects = realm.objects(Menu.self).filter("isFavorite == true")
            menus = Array(objects)
            completion(.success(nil))
         } catch {
            completion(.failure(error))
        }
    }

    func favoritesCellViewModell(at indexPath: IndexPath) -> FavoritesCellViewModel {
        return FavoritesCellViewModel(menu: menus[indexPath.row])
    }
}

