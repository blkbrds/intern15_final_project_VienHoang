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
            guard let self = self else {
                completion(.failure(Api.Error.invalidRequest))
                return }
            switch result {
            case .success(let result):
                self.menus = result.menu
                for index in 0 ..< self.menus.count {
                    self.dispatchGroup.enter()
                    self.loadImage(at: index) { (result) in
                        self.dispatchGroup.leave()
                    }
                }
                self.dispatchGroup.notify(queue: .main) {
                    print("Da goi xong het api trong vong lap for")
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
    
    func loadImage(at index: Int, completion: @escaping APICompletion) {
        id = menus[index].id
        Api.Path.Home.basePath = id
        let params = Api.Home.ParamsThumnail(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: App.String.v, ll: App.String.ll)
        Api.Home.getImage(params: params) { [weak self] (result) in
            guard let this = self else {
                completion(.failure(Api.Error.invalidRequest))
                return }
            switch result {
            case .success(let image):
                this.menus[index].image = image
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
