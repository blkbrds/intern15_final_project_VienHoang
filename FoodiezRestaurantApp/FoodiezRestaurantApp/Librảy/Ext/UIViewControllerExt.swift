//
//  UIViewControllerExt.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/2/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit
import SwiftUtils
import ObjectMapper

extension UIViewController {

    func alert(title: String? = nil,
               msg: String,
               buttons: [String] = ["OK"],
               preferButton: String = "",
               handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for button in buttons {
            let action = UIAlertAction(title: button, style: .default, handler: { action in
                handler?(action)
            })
            alert.addAction(action)

            // Bold button title
            if preferButton.isNotEmpty && preferButton == button {
                alert.preferredAction = action
            }
        }

        present(alert, animated: true, completion: nil)
    }
}
