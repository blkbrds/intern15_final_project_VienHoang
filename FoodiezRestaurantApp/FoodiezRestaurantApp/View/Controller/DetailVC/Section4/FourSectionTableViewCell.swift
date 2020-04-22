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

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet weak var connerView: UIView!

    let locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    let newYorkLocation = CLLocation(latitude: 40.7, longitude: -74)

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
        mapView.delegate = self
        center(location: newYorkLocation)
        addAnnotation()
        chiDuong()
    }

    func center(location: CLLocation) {
        mapView.setCenter(location.coordinate, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

    func chiDuong() {
        guard let vien = viewModel?.menus.detailImage else {
            return
        }
        let source = CLLocationCoordinate2D(latitude: 40.7, longitude: -74)
        let destination = CLLocationCoordinate2D(latitude: vien.lat, longitude: vien.lng)
        routing(source: source, destination: destination)
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

    func addAnnotation() {
        guard let viewModel = viewModel else {
            return
        }
        if let location = viewModel.menus.detailImage?.locationCoordinate {
            let annotations = MKPointAnnotation()
            annotations.coordinate = location
            annotations.title = viewModel.menus.detailImage?.name
            annotations.accessibilityHint = viewModel.menus.detailImage?.id
            self.mapView.addAnnotation(annotations)
            mapView.showsUserLocation = true
        }
    }
}


//MARK: - MapView Delegate
extension FourSectionTableViewCell: MKMapViewDelegate {

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
                button.accessibilityHint = viewModel?.menus.detailImage?.id
                view.rightCalloutAccessoryView = button
                let imagePlace = "\(viewModel?.menus.detailImage?.prefix ?? "")70x70\(viewModel?.menus.detailImage?.suffix ?? "")"
                view.leftCalloutAccessoryView = UIImageView(image: UIImage(named: imagePlace))
                view.canShowCallout = true
            }
            return view
        } else {
            return nil
        }
    }
    @objc func selectPinView(_ sender: UIButton?) {
        guard let id = viewModel?.menus.detailImage?.id, sender?.accessibilityHint == id else {
            return
        }
        let vc = MapViewController()
        vc.navigationController?.pushViewController(vc, animated: true)
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
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 3
            return renderer

        } else if let circle = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: circle)
            circleRenderer.fillColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
            circleRenderer.strokeColor = .red
            circleRenderer.lineWidth = 1
            circleRenderer.lineDashPhase = 10
            return circleRenderer

        } else {
            return MKOverlayRenderer()
        }
    }
}
