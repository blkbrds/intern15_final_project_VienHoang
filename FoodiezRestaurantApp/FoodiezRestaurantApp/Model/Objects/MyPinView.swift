//
//  MyPinView.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/5/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import Foundation
import MapKit

final class MyPinView: MKPinAnnotationView {
    
    //MARK: - Properties
    private var imageView: UIImageView!
    
    //MARk: Life cycle
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = UIImage(named: "no_image")
        addSubview(imageView)
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
    }
    
    //MARK: - Life cycle
    override var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            if let _ = imageView {
                imageView.image = newValue
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

