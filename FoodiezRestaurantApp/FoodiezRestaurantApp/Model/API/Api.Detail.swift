//
//  API.Location.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/5/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

//MARK: - Api
extension Api.Detail {
    struct Params {

        //MARK: - Properties
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

    //MARk: - Static functions
    @discardableResult
    static func getLocation(params: Params, completion: @escaping Completion<[Menu]>) -> Request? {
        let path = Api.Path.Search.path + Api.Path.Search.query
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject,
                        let response = json["response"] as? JSObject,
                        let venues = response["venues"] as? JSObject else {
                            return
                    }
                    var menus: JSArray = []
                    for item in venues {
                        return
                    }
                }
            }
        }
    }
}

