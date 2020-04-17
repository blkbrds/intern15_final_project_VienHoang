//
//  FourSectionTableViewCell.swift
//  FoodiezRestaurantApp
//
//  Created by user on 4/16/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit
import MapKit

class FourSectionTableViewCell: UITableViewCell {

    //MARK: - Properties
    let locationManager = CLLocationManager()
    let newYorkLocation = CLLocation(latitude: 40.7, longitude: -74)

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet weak var connerView: UIView!

    var viewModel: FourSectionViewModel? {
        didSet {
            updateUI()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        mapView.layer.cornerRadius = 30
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10))
    }

    func updateUI() {
        guard let viewModel = viewModel else { return }

    }
}
