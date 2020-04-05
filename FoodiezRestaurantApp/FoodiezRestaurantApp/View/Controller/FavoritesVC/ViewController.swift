//
//  ViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/23/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit
import MVVM
import SwiftUtils

class ViewController: UIViewController, MVVM.View {

    // Conformance for ViewEmptyProtocol
    var isViewEmpty: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.accessibilityIdentifier = String(describing: type(of: self))
 //       view.removeMultiTouch()
        setupUI()
        setupData()
    }
    
    func setupUI() {}
    
    func setupData() {}
}
