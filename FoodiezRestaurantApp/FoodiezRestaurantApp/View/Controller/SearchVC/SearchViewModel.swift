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

    enum DisplayType: Int {
        case keyword
        case menu
    }

    //MARK: Properties
    var displayType: DisplayType = .keyword
    var menus: [Menu] = []
    var keywords: [Keyword] = []

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

    func saveKeyword(text: String, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let keyword = Keyword(keyword: text, searchTime: Date())
            try realm.write {
                realm.create(Keyword.self, value: keyword, update: .all)
            }
            searchLocation(keyword: text, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }

    func getKeyword(at indexPath: IndexPath) -> String {
        return keywords[indexPath.row].keyword
    }

    func numberOfRows(section: Int) -> Int {
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
            return SearchLocationViewModel(menu: menus[indexPath.row])
        }
    }

    private func searchLocation(keyword: String, completion: @escaping APICompletion) {
        let param = Api.Search.Params(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: App.String.v, ll: App.String.ll, query: keyword)
        Api.Search.getSearch(params: param) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let menus):
                self.menus = menus
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func viewModelForDetail(at indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(menu: menus[indexPath.row])
    }

    func heightForRowAt(at indexPath: IndexPath) -> CGFloat {
        guard let sectionType = DisplayType(rawValue: indexPath.section) else { return .zero }
        switch sectionType {
        case .keyword, .menu:
            return 100
        }
    }
}
