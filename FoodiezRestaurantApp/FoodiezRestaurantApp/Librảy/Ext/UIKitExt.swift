//
//  UIKitExt.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/2/20.
//  Copyright © 2020 VienH. All rights reserved.
//
import UIKit

extension UIViewController {
    func alert(error: Error) {
        guard error.code != 1_000 else { return }
        alert(title: "ERROR", msg: error.localizedDescription, buttons: ["OK"], handler: nil)
    }

    func alert(title: String? = nil, msg: String, buttons: [String], handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for button in buttons {
            let action = UIAlertAction(title: button, style: .cancel, handler: { action in
                handler?(action)
            })
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
