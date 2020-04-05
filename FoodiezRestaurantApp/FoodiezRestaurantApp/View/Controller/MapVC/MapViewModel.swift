////
////  MapViewModel.swift
////  FoodiezRestaurantApp
////
////  Created by user on 3/5/20.
////  Copyright © 2020 VienH. All rights reserved.
////
//

import Foundation
import GoogleMaps
import MVVM

final class MapViewModel: ViewModel {

// MARK: - Properties
    var places: [Menu] = []
    var markers: [GMSMarker] = []

    func createMarkers() {
        markers = []
        for place in places {
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: place.position.lat, longitude: place.position.long))
            marker.title = place.name
            marker.snippet = place.address
            marker.appearAnimation = .pop
            markers.append(marker)
        }
    }
    
    func getPlaceSelected(with id: String) -> Menu {
        for place in places {
            if place.id == id {
                return place
            }
        }
        return Menu()
    }
    
    func getPoints(currentLocation: CLLocation , destinationLocation: CLLocation, travelMode: TravelModes, completed: @escaping (Bool, String) -> Void) {
        
        var locationA: String {
            return String(currentLocation.coordinate.latitude) + "," + String(currentLocation.coordinate.longitude)
        }
        var locationB: String {
            return String(destinationLocation.coordinate.latitude) + "," + String(destinationLocation.coordinate.longitude)
        }
        Api.Direction.getDirectionPoints(originLocation: locationA, destinationLocation: locationB, travelMode: .driving) { (result) in
            switch result {
            case .failure(let error):
                completed(false, error.localizedDescription)
            case .success(let points):
                completed(true, points.points)
            }
        }
    }
}
