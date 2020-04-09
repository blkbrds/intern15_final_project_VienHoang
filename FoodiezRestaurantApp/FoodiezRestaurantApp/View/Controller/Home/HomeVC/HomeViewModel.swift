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
    let limit: Int = 5
    var dem: Int = 0
    var id: String = ""
    var dispatchGroup = DispatchGroup()
    
    //MARK: - Public functions
    func loadAPIForHome(completion: @escaping APICompletion) {
        let params = Api.Home.Params(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: App.String.v, ll: App.String.ll, limit: limit)
        Api.Home.getMenus(params: params) { [weak self] (result) in
            guard let this = self else {
                completion(.failure(Api.Error.invalidRequest))
                return }
            switch result {
            case .success(let result):
                this.menus = result.menu
                for index in 0 ..< this.menus.count {
                    this.dispatchGroup.enter()
                    this.loadImage(at: index) { (result) in
                        this.dispatchGroup.leave()
                    }
                }
                this.dispatchGroup.notify(queue: .main) {
                    completion(.success)
                }
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
    
    func viewModelForMap() -> MapViewModel {
        return MapViewModel(menus: menus)
    }
    
    func loadImage(at index: Int, completion: @escaping APICompletion) {
        id = menus[index].id
        Api.Path.Home.basePath = id
        let params = Api.Home.ParamsThumbnail(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: App.String.v, ll: App.String.ll)
        Api.Home.getVenues(params: params) { [weak self] (result) in
            guard let this = self else {
                completion(.failure(Api.Error.invalidRequest))
                return }
            switch result {
            case .success(let result):
                this.menus[index].placeImage = result?.detailImage
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
