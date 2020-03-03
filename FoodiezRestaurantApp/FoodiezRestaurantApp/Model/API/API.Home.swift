//
//  API.Home.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/2/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Home {
    struct Params {
        var clientID: String
        var clientSecret: String
        var v: String
        var ll: String

        func toJSON() -> [String: Any] {
            ["client_id": clientID,
                "client_secret": clientSecret,
                "v": v,
                "ll": ll]
        }
    }

    @discardableResult
    static func getCategories(params: Params, completion: @escaping Completion<[Categories]>) -> Request? {
        let path = Api.Path.Home.path
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject,
                        let response = json["response"] as? JSObject,
                        let venues = response["venues"] as? JSArray else {
                            return
                    }
                    var categories: JSArray = []
                    for item in venues {
                        guard let item = item["categories"] as? JSArray else {
                            return
                        }
                        categories.append(contentsOf: item)
                    }
                    let category = Mapper<Categories>().mapArray(JSONArray: categories)
                    completion(.success(category))
                }
            }
        }
    }
}
