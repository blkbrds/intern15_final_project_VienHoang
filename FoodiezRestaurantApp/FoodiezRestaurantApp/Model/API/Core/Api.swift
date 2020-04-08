//
//  Api.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/2/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import Alamofire

final class Api {

    struct Path {
        static let baseURL = "https://api.foursquare.com/v2/venues"
    }

    struct Home { }

    struct Categories { }

    struct Detail { }

    struct Search { }

    struct Map { }
}

extension Api.Path {
    struct Home {
        static var path: String {
            return baseURL / "search"
        }

        static var basePath: String = ""
        static var homePath: String {
            return baseURL / basePath
        }
    }

    struct Detail {
        static var basePath: String = ""
        static var path: String {
            return baseURL / basePath
        }
    }

    struct Search {
        static var path: String {
            return baseURL / "search"
        }
    }

    struct Map {
        static var path: String {
            return baseURL / "Search"
        }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

private func / (left: String, right: Int) -> String {
    return left.appending(path: "\(right)")
}
