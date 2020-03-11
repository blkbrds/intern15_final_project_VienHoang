//
//  InputViewExt.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/11/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
  var string: String { return text ?? "" }
}
extension UITextField {
  var string: String { return text ?? "" }
}
extension UITableView {
  func register(name: String) {
    let nib = UINib(nibName: name, bundle: Bundle.main)
    register(nib, forCellReuseIdentifier: name)
  }
}
