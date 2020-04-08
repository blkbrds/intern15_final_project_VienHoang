//
//  DetailViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class DetailViewModel {

    //MARK: - Properties
    var menu: Menu
    var id: String = ""

    //MARK: Init
    init(menu: Menu = Menu()) {
        self.menu = menu
    }

    //MARK: - Public functions
    func loadApiDetail(completion: @escaping APICompletion) {
        Api.Path.Detail.basePath = menu.id
        let params = Api.Home.ParamsThumbnail(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: App.String.v, ll: App.String.ll)
        Api.Home.getImage(params: params) { [weak self] (result) in
            guard let self = self else {
                completion(.failure(Api.Error.invalidRequest))
                return }
            switch result {
            case .success(let channel):
                self.menu.detailImage = channel
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func isFavorites(completion: RealmCompletion) {
        do {
            let realm = try Realm()
            try realm.write {
                menu.isFavorite = !menu.isFavorite
                realm.create(Menu.self, value: menu, update: .modified)
            }
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
    }

    func loadFavoritesStatus(completion: (Bool) -> Void) {
        do {
            let realm = try Realm()
            let objects = realm.objects(Menu.self) .filter("id = %d AND isFavorite == true", menu.id)
            if !objects.isEmpty {
                completion(true)
            } else {
                completion(false)
            }
        } catch {
            completion(false)
        }
    }
}
