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
        var v = "20150624"
        var ll = "16.0776738,108.197205"
        
        //MARk: - Public functions
        func toJSON() -> [String: Any] {
            ["client_id": clientID,
                "client_secret": clientSecret,
                "v": v,
                "ll": ll]
        }
    }

    //MARK: - Static functions
    @discardableResult
    static func getMenus(params: Params, completion: @escaping Completion<[Menu]>) -> Request? {
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
                    let menu = Mapper<Menu>().mapArray(JSONArray: venues)
                    completion(.success(menu))
                }
            }
        }
    }
}
