//
//  Api+Data.swift
//  FoodiezRestaurantApp
//
//  Created by user on 4/3/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

extension Data {

    func convertToJSON(from data: Data) -> [String: Any] {
        var json: [String: Any] = [:]
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                json = jsonObj
            }
        } catch {
            print("Casting Error")
        }
        return json
    }
}

extension Dictionary {
    func convertToData() -> Data {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            return data
        } catch {
            fatalError("JSON casting error")
        }
    }
}

