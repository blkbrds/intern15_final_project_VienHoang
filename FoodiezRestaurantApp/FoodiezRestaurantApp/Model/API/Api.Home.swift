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

        func toJSON() -> [String: Any] {
            ["client_id": clientID,
                "client_secret": clientSecret,
                "v": v,
                "ll": ll]
        }
    }
    
    struct Result: Mappable {
      var venues: JSArray = []
      var menu: [Menu] = []
      init?(map: Map) { }
      mutating func mapping(map: Map) {
        venues <- map["response.venues"]
        menu <- map["response.venues"]
      }
    }

    //MARK: - Static functions
    @discardableResult
    static func getMenus(params: Params, completion: @escaping Completion<Result>) -> Request? {
        let path = Api.Path.Home.path
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject, let result = Mapper<Result>().map(JSON: json) else
//                        let response = json["response"] as? JSObject,
//                        let venues = response["venues"] as? JSArray else {
                        {
                            return
                    }

//                    let menu = Mapper<Result>().mapArray(JSONArray: result)
                    completion(.success(result))
                }
            }
        }
    }
}
