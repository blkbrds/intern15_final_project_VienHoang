//
//  MapViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 3/5/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    //MARK: - Properties
    let locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()

    //MARK: - IBOutlet
    @IBOutlet private weak var mapView: MKMapView!

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        LocationManager.shared().getCurrentLocation(completion: { [weak self] (location) in
            guard let this = self else { return }
            this.currentLocation = location.coordinate
            this.center(location: location.coordinate)
        })
    }

    func center(location: CLLocationCoordinate2D) {
        mapView.setCenter(location, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }

    func routing(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
            
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
            
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
            
        case .restricted:
            print("parental control setting disallow location data")
            
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
            
        default:
            print("default")
        }
    }
}

//MARK: - MapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let pin = annotation as? MKPointAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: pin, reuseIdentifier: identifier)
                view.animatesDrop = true
                view.pinTintColor = .green
                view.canShowCallout = true
            }
            return view
        } else if let annotation = annotation as? MyPin {
            let identifier = "mypin"
            var view: MyPinView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MyPinView {
                dequeuedView.annotation = annotation as? MKAnnotation
                view = dequeuedView
            } else {
                view = MyPinView(annotation: annotation as? MKAnnotation, reuseIdentifier: identifier)
                let button = UIButton(type: .detailDisclosure)
                button.addTarget(self, action: #selector(selectPinView(_:)), for: .touchDown)
                view.rightCalloutAccessoryView = button
                view.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "macker"))
                view.canShowCallout = true
            }
            return view
        } else {
            return nil
        }
    }

    //MARK: - Action
    @objc func selectPinView(_ sender: UIButton?) {
        print("select button detail")
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("selected callout")
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("selected pin")
    }

    //MARK: - Public functions
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 3
            return renderer
        } else if let circle = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: circle)
            circleRenderer.fillColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
            circleRenderer.strokeColor = .blue
            circleRenderer.lineWidth = 1
            circleRenderer.lineDashPhase = 10
            return circleRenderer
        } else {
            return MKOverlayRenderer()
        }
    }
}

