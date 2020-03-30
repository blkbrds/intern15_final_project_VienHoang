//
//  Api.Search.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/28/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

//MARK: - Extension Api
extension Api.Search {
    struct Params {

        //MARK: - Properties
        var clientID: String
        var clientSecret: String
        var v: String
        var ll: String
        var query: String

        //MARK: Public Functions
        func toJSON() -> [String: Any] {
            ["client_id": clientID,
                "client_secret": clientSecret,
                "v": v,
                "ll": ll,
                "query": query]
        }
    }

    //MARK: - Static functions
    @discardableResult
    static func getSearch(params: Params, completion: @escaping Completion<[Menu]>) -> Request? {
        let path = Api.Path.Home.path
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject,
                        let response = json["response"] as? JSObject, let venues = response["venues"] as? JSArray
                        else { return
                    }
                    let channel = Mapper<Menu>().mapArray(JSONArray: venues)
                    completion(.success(channel))
                }
            }
        }
    }
}

