//
//  HomeViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class HomeViewModel {
    var categories: [Categories] = []

    func loadAPIForHome(completion: @escaping APICompletion) {
        let params = Api.Home.Params(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: "20130815", ll: "40.7,-74")
        Api.Home.getCategories(params: params) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let category):
                self.categories = category
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> CollectionCellViewModel {
        return CollectionCellViewModel(category: categories[indexPath.row])
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return categories.count
    }
}
