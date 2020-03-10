//
//  HomeViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class HomeViewModel {
    var menus: [Menus] = []

    func loadAPIForHome(completion: @escaping APICompletion) {
        let params = Api.Home.Params(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: App.String.v, ll: App.String.ll)
        Api.Home.getMenus(params: params) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let menu):
                self.menus = menu
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func viewModelForCell(at indexPath: IndexPath) -> CollectionCellViewModel {
        return CollectionCellViewModel(menu: menus[indexPath.row])
    }

    func numberOfIemsInSection(section: Int) -> Int {
        return menus.count
    }
}
