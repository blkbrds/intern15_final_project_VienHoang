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
        var limit: Int

        //MARK: Public Functions
        func toJSON() -> [String: Any] {
            ["client_id": clientID,
                "client_secret": clientSecret,
                "v": v,
                "ll": ll,
                "limit": limit]
        }
    }

    struct ParamsThumbnail {
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

    @discardableResult
    static func getVenues(params: ParamsThumbnail, completion: @escaping Completion<VenuesDetail?>) -> Request? {
        let path = Api.Path.Home.homePath
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
                    let channel = Mapper<VenuesDetail>().map(JSONObject: venue)
                    completion(.success(channel))
                }
            }
        }
    }
}
