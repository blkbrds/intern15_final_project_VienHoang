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

//MARK: - Extension Api
extension Api.Home {
    struct Params {

        //MARK: - Properties
        var clientID: String
        var clientSecret: String
        var v: String
        var ll: String

        //MARK: Public Functions
        func toJSON() -> [String: Any] {
            ["client_id": clientID,
                "client_secret": clientSecret,
                "v": v,
                "ll": ll]
        }
    }

    struct ValueResult: Mappable {
        var venues: JSArray = []
        var menu: [Menu] = []

        //MARK: - Init
        init?(map: Map) { }
        mutating func mapping(map: Map) {
            venues <- map["response.venues"]
            menu <- map["response.venues"]
        }
    }

    //MARK: - Static functions
    @discardableResult
    static func getMenus(params: Params, completion: @escaping Completion<ValueResult>) -> Request? {
        let path = Api.Path.Home.path
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject, let result = Mapper<ValueResult>().map(JSON: json) else {
                        return
                    }
                    completion(.success(result))
                }
            }
        }
    }
}
