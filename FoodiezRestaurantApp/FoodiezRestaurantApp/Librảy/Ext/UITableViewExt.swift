//
//  UITableViewExt.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/12/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
  func register(name: String) {
    let nib = UINib(nibName: name, bundle: Bundle.main)
    register(nib, forCellReuseIdentifier: name)
  }
}
