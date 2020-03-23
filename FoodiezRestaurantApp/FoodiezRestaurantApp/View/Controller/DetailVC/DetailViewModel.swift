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
    var menu: Menu?

    //MARK: Init
    init(menu: Menu) {
        self.menu = menu
    }

    //MARK: - Public functions
    func loadApiDetail(completion: @escaping APICompletion) {
        guard let menu = menu else {
            return
        }
        Api.Path.Detail.basePath = menu.id
        let params = Api.Detail.Params(clientID: App.String.clientID, clientSecret: App.String.clientSecret, v: App.String.v, ll: App.String.ll)
        Api.Detail.getLocation(params: params) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let channel):
                self.menu?.detailImage = channel
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func isFavorites(completion : RealmCompletion) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.create(DetailImage.self, value: "id")
        }
    }
}
