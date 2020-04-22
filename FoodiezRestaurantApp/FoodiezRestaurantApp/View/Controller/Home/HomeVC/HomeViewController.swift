//
//  HomeViewController.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit
import MapKit
final class HomeViewController: ViewController {

    //MARK: - Properties
    let locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    let newYorkLocation = CLLocation(latitude: 40.7, longitude: -74)

    //MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!

    //MARK: - Properties
    var viewModel = HomeViewModel()
    var dispatchGroup = DispatchGroup()
    private var refreshControlCollectionView = UIRefreshControl()
    var titleArry: [String] = Array()


    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        center(location: newYorkLocation)
        configUI()
        fetchData()
    }

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
                annotations.subtitle = item.address
                self.mapView.addAnnotation(annotations)
            }
        }
    }

    //MARK: Public functions
    func updateUI() {
        if viewModel.isShowTableView {
            collectionView.isHidden = false
            mapView.isHidden = true
            collectionView.reloadData()
            refreshControlCollectionView.endRefreshing()
        } else {
            collectionView.isHidden = true
            mapView.isHidden = false
        }
    }

    override func setNavi() {
        super.setNavi()
        title = "Home"
        let tableViewButton = UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .plain, target: self, action: #selector(showTableView))
        navigationItem.rightBarButtonItem = tableViewButton
        tableViewButton.tintColor = .black
    }

    @objc func showTableView() {
        //change barbutton
        let collectionViewButton = UIBarButtonItem(image: #imageLiteral(resourceName: "map"), style: .plain, target: self, action: #selector(showCollectionView))
        navigationItem.rightBarButtonItem = collectionViewButton
        collectionViewButton.tintColor = .black
        //change isShow
        viewModel.changeDisplay { (done) in
            if done {
                self.updateUI()
            } else {
                //show alertview --> bao' loi~
                let alert = UIAlertController(title: "Error", message: "Khong Lay Duoc Data", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    @objc func showCollectionView() {
        let tableViewButton = UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .plain, target: self, action: #selector(showTableView))
        navigationItem.rightBarButtonItem = tableViewButton
        tableViewButton.tintColor = .black
        viewModel.changeDisplay { (done) in
            if done {
                self.updateUI()
            } else {
                //show alertview --> bao' loi~
                let alert = UIAlertController(title: "Error", message: "Khong Lay duoc DaTa", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    func configUI() {
        configTableView()
        refreshControlCollection()
    }

    func configTableView() {
        let nib = UINib(nibName: App.Identifier.collectionViewCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: App.Identifier.collectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func refreshControlCollection() {
        refreshControlCollectionView.tintColor = .black
        let tableViewAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        refreshControlCollectionView.attributedTitle = NSAttributedString(string: App.String.refresh, attributes: tableViewAttributes)
        refreshControlCollectionView.addTarget(self, action: #selector(tableViewDidScrollToTop), for: .valueChanged)
        collectionView.addSubview(refreshControlCollectionView)
    }

    @objc func tableViewDidScrollToTop() {
        loadApi(isLoadMore: false)
    }

    func fetchData() {
        loadApi(isLoadMore: false)
    }

    func loadApi(isLoadMore: Bool) {
        HUD.show()
        viewModel.loadAPIForHome(isLoadMore: isLoadMore) { [weak self] (reslut) in
            HUD.popActivity()
            guard let this = self else { return }
            switch reslut {
            case .success:
                this.updateUI()
                this.addPin()
            case .failure(let error):
                this.alert(error: error)
            }
            this.viewModel.isLoadding = false
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.25) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
}

//MARK: - Extention CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionVIew: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: App.Identifier.collectionViewCell, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.size.height {
            loadApi(isLoadMore: true)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.size.height {
            loadApi(isLoadMore: true)
        }
    }
}

//MARK: - Extension CollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Config.widthSize, height: Config.heightSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Config.minimumLineSpacingForSectionAt)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat (Config.minimumInteritemSpacingForSectionAt)
    }
}

//MARK: - Extension CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.viewModel = viewModel.viewModelForDetailCell(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Extension HomeViewController
extension HomeViewController {
    struct Config {
        static let minimumLineSpacingForSectionAt: Float = 10
        static let minimumInteritemSpacingForSectionAt: CGFloat = 10
        static let screenWidth = UIScreen.main.bounds.width - 30
        static let widthSize = (Config.screenWidth / 2) - 15
        static let heightSize = (Config.screenWidth / 3) * 6 / 4
    }
}

//MARK: - MapView Delegate
extension HomeViewController: MKMapViewDelegate {
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
        } else if
            let annotation = annotation as? MyPin {
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
        print("detail is me")
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("selected callout")
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //        let vc = DetailViewController()
        //        vc.viewModel = viewModel.viewModelForDetailCell(at:
        //        navigationController?.pushViewController(vc, animated: true)
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


