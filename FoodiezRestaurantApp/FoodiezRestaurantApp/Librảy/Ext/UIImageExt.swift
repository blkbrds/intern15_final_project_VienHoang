//
//  UIImageExt.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/2/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String?, defaultImage: UIImage = UIImage()) {
        guard let urlStr = url, let url = URL(string: urlStr) else {
            self.image = defaultImage
            return
        }
        self.kf.setImage(with: url)
    }
}
