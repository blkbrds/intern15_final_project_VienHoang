//
//  HomeViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    //MARK: Properties
    var menus: [Menu] = []

    //MARK: - Public functions
    func loadAPIForHome(completion: @escaping APICompletion) {
        let params = Api.Home.Params(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: App.String.v, ll: App.String.ll)
        Api.Home.getMenus(params: params) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let result):
                this.menus = result.menu
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func viewModelForDetailCell(at indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(menu: menus[indexPath.row])
    }

    func viewModelForCell(at indexPath: IndexPath) -> CollectionCellViewModel {
        return CollectionCellViewModel(menu: menus[indexPath.row])
    }

    func numberOfRows(in section: Int) -> Int {
        return menus.count
    }
    
    func loadImage(at indexPath: IndexPath, completion: @escaping APICompletion) {
        Api.Path.Home.basePath = menus[indexPath.row].id
        let params = Api.Home.ParamsThumnail(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: App.String.v, ll: App.String.ll)
        Api.Home.getImage(params: params) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let image):
                this.menus[indexPath.row].image = image
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
