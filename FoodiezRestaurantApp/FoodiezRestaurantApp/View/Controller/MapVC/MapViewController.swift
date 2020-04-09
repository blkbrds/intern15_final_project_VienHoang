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
    var viewModel = MapViewModel()
    let newYorkLocation = CLLocation(latitude: 40.7, longitude: -74)

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        center(location: newYorkLocation)
        addPin()
    }

    //MARK: - Display Map
    func center(location: CLLocation) {
        mapView.setCenter(location.coordinate, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.setCameraZoomRange(.none, animated: true)
    }

    //MARK: Public functions
    func addPin() {
        viewModel.menus.forEach { (item) in
            if let location = item.locationCoordinate {
                let annotations = MKPointAnnotation()
                annotations.coordinate = location
                annotations.title = item.name
                self.mapView.addAnnotation(annotations)
            }
        }
    }
}

//MARK: - MapView Delegate
extension ViewController: MKMapViewDelegate {
    
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
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MyPinView(annotation: annotation, reuseIdentifier: identifier)
                let button = UIButton(type: .detailDisclosure)
                button.addTarget(self, action: #selector(selectPinView(_:)), for: .touchDown)
                view.rightCalloutAccessoryView = button
                view.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "pin"))
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

    //MARK: - Renderer
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

extension MapViewController: MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")

        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
            manager.requestLocation()

        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
            manager.requestLocation()

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
