//
//  SearchViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import RealmSwift
final class SearchViewModel {

    enum DisplayType {
        case keyword
        case menu
    }

    var displayType: DisplayType = .keyword
    var menus: [Menu] = []
    var keywords: [Keyword] = []

    func numberOfRowsInSection(in section: Int) -> Int {
        return menus.count
    }

    func loadKeywords(completion: RealmCompletion) {
        do {
            let realm = try Realm()
            let objects = realm.objects(Keyword.self).sorted(byKeyPath: "searchTime", ascending: false)
            keywords = Array(objects)
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
    }

    func loadKeywords(text: String, completion: RealmCompletion) {
        do {
            let realm = try Realm()
            var objects: Results<Keyword>
            if text == "" {
                objects = realm.objects(Keyword.self).sorted(byKeyPath: "searchTime", ascending: false)
            } else {
                objects = realm.objects(Keyword.self).filter("keyword BEGINSWITH[cd] %@", text)
            }
            keywords = Array(objects)
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
    }

    func saveKeyword(text: String, completion: RealmCompletion) {
        do {
            let realm = try Realm()
            let keyword = Keyword(keyword: text, searchTime: Date())
            try realm.write {
                realm.create(Keyword.self, value: keyword, update: .all)
            }
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        switch displayType {
        case .keyword:
            return keywords.count
        case .menu:
            return menus.count
        }
    }

    func viewModelForCell(at indexPath: IndexPath) -> SearchCellViewModel {
        switch displayType {
        case .keyword:
            return SearchKeyCellViewModel(key: keywords[indexPath.row].keyword)
        case .menu:
            return FavoritesCellViewModel(menu: menus[indexPath.row])
        }
    }
}
