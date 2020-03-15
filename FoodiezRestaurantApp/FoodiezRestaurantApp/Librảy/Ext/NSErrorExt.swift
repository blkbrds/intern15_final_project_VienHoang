//
//  NSErrorExt.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/2/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation

private struct ErrorFieldKey {
    static var errors = "Errors"
}

extension NSError {
    var errorsString: [String] {
        set {
            objc_setAssociatedObject(self, &ErrorFieldKey.errors, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let errors = objc_getAssociatedObject(self, &ErrorFieldKey.errors) as? [String] else { return [] }
            return errors
        }
    }
}

