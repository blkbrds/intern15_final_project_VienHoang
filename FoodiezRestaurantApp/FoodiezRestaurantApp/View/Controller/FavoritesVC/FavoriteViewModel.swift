//
//  FavoriteViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/23/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoriteViewModelDelegate: class {
    func viewModel(viewModel: FavoriteViewModel, needperfomAction action: FavoriteViewModel.Action)
}

final class FavoriteViewModel {
    enum Action {
        case reloadData
    }

    //MARK: - Properties
    var menus: [Menu] = []
    var notifacation: NotificationToken?
    weak var delegate: FavoriteViewModelDelegate?

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

    func setUpObsever() {
        do {
            let realm = try Realm()
            notifacation = realm.objects(Menu.self).observe({ [weak self] (action) in
                guard let self = self else { return }
                switch action {
                case .update:
                    self.delegate?.viewModel(viewModel: self, needperfomAction: .reloadData)
                default:
                    break
                }
            })
        } catch { }
    }

    func favoritesCellViewModell(at indexPath: IndexPath) -> FavoritesCellViewModel {
        return FavoritesCellViewModel(menu: menus[indexPath.row])
    }

    func removeAllFavorites(completion: RealmCompletion) {
        do {
            let realm = try Realm()
            let objects = realm.objects(Menu.self).filter("isFavorite == true")
            for item in objects {
                try realm.write {
                    item.isFavorite = false
                }
            }
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
    }
}
