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
        var v: String
        var ll: String

        func toJSON() -> [String: Any] {
            ["client_id": clientID,
                "client_secret": clientSecret,
                "v": v,
                "ll": ll]
        }
    }

    //MARk: - Static functions
    @discardableResult
    static func getLocation(params: Params, completion: @escaping Completion<DetailImage?>) -> Request? {
        let path = Api.Path.Detail.path
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject,
                        let response = json["response"] as? JSObject,
                        let venue = response["venue"] as? JSObject else {
                            return
                    }
                    let channel = Mapper<DetailImage>().map(JSONObject: venue)
                    completion(.success(channel))
                }
            }
        }
    }
}
