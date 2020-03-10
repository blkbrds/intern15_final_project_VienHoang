////
////  MapViewModel.swift
////  FoodiezRestaurantApp
////
////  Created by user on 3/5/20.
////  Copyright © 2020 VienH. All rights reserved.
////
//
//import Foundation
//
//final class MapViewModel {
//    var location: [Menus] = []
//
//    func loadApiForSearch(completion: @escaping APICompletion) {
//        let params = Api.Detail.Params(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: "20201805", ll: "16.0776738,108.197205")
//        Api.Detail.getLocation(params: params) { [weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let menu):
//                self.location = menu
//                completion(.success)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
