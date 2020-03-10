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
        var v = "20150624"
        var ll = "16.0776738,108.197205"

        func toJSON() -> [String: Any] {
            ["client_id": clientID,
                "client_secret": clientSecret,
                "v": v,
                "ll": ll]
        }
    }

    @discardableResult
    static func getMenus(params: Params, completion: @escaping Completion<[Menus]>) -> Request? {
        let path = Api.Path.Home.path
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject,
                        let response = json["response"] as? JSObject,
                        let categories = response["categories"] as? JSArray else {
                            return
                    }

                    var menus: JSArray = []
                    for item in categories {
                        guard let item = item["categories"] as? JSArray else {
                            return
                        }
                        menus.append(contentsOf: item)
                    }
                    let menu = Mapper<Menus>().mapArray(JSONArray: menus)
                    completion(.success(menu))
                }
            }
        }
    }
}
