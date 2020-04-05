//
//  Api.Direction.swift
//  FoodiezRestaurantApp
//
//  Created by user on 4/3/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import Alamofire

enum TravelModes: String {
    case driving = "driving"
    case walking = "walking"
    case bicycling = "Bicycling"
    case transit = "transit"
}

extension Api.Direction {
    
    struct DirectionResult {
        var points: String
    }

    struct QuerryString {
        struct direction {
            var originLocation: String
            var destinationLocation: String
            var travelMode: TravelModes
            var url: String {
                return Api.BasePath.baseURLDirection + "origin=" +
                    originLocation + "&destination=" + destinationLocation + "&mode=" + travelMode.rawValue + "&key=" + Api.Key.GoogleAPI
            }
        }
    }

    //Rrequesting Alamofire
    static func getDirectionPoints(originLocation: String, destinationLocation: String, travelMode: TravelModes, completion: @escaping Completion<DirectionResult>) {
        let url: String = QuerryString.direction.init(originLocation: originLocation, destinationLocation: destinationLocation, travelMode: travelMode).url
        Alamofire.request(url).responseJSON { response in
            guard let data = response.data else {
                if let error = response.error {
                    completion(.failure(error))
                }
                return
            }
            let json = data.convertToJSON(from: data)
            guard let routes = json["routes"] as? [[String: Any]] else { return }
            var pointsResult: String = ""
            for route in routes {
                let routeOverviewPolyline = route["overview_polyline"] as? [String: Any]
                if let points = routeOverviewPolyline?["points"] as? String  {
                    pointsResult = points
                }
            }
            completion(.success(DirectionResult(points: pointsResult)))
        }
    }
}

