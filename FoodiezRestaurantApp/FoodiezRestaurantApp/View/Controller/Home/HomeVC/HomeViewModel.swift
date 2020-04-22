//
//  HomeViewModel.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import CoreLocation

final class HomeViewModel {

    //MARK: Properties
    var menus: [Menu] = []
    var limit: Int = 10
    var dem: Int = 0
    var id: String = ""
    var dispatchGroup = DispatchGroup()
    var isShowTableView: Bool = true
    var isLoadding: Bool = false
    var location: CLLocationCoordinate2D?
    func changeDisplay(completion: (Bool) -> ()) {
        //data
        isShowTableView = !isShowTableView
        //call back
        completion(true)
    }
    
    init(menus: [Menu] = []) {
        self.menus = menus
    }
    //MARK: - Public functions
    func loadAPIForHome(isLoadMore: Bool, completion: @escaping APICompletion) {
        guard !isLoadding else {
            completion(.failure(Api.Error.invalidRequest))
            return }
        isLoadding = true
        let params = Api.Home.Params(clientID: App.String.clientIDHome, clientSecret: App.String.clientSecretHome, v: App.String.v, ll: App.String.ll, limit: limit)
        Api.Home.getMenus(params: params) { [weak self] (result) in
            guard let this = self else {
                completion(.failure(Api.Error.invalidRequest))
                return }
            switch result {
            case .success(let result):
                if isLoadMore {
                    this.menus.append(contentsOf: result.menu)
                    for index in 0 ..< this.menus.count {
                        this.dispatchGroup.enter()
                        this.loadImage(at: index) { (result) in
                            this.dispatchGroup.leave()
                        }
                    }
                } else {
                    this.menus = result.menu
                    for index in 0 ..< this.menus.count {
                        this.dispatchGroup.enter()
                        this.loadImage(at: index) { (result) in
                            this.dispatchGroup.leave()
                        }
                    }
                }
                this.limit += 5
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
        let params = Api.Home.ParamsThumbnail(clientID: App.String.clientIDHome, clientSecret: App.String.clientSecretHome, v: App.String.v, ll: App.String.ll)
        Api.Home.getVenues(params: params) { [weak self] (result) in
            guard let this = self else {
                completion(.failure(Api.Error.invalidRequest))
                return }
            switch result {
            case .success(let result):
                this.menus[index].placeImage = result?.imageHome ?? ""
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadMore(completion: @escaping APICompletion) {

    }
}
