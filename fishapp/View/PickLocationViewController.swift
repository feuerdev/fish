//
//  PickByMapViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 27.10.20.
//
import UIKit
import MapKit

class PickLocationViewController : UIViewController {
    
    @IBOutlet weak var mvMap: MKMapView!
    @IBOutlet weak var btnSearch: UIButton!
    
    var presenter: PickLocationPresenter?
    
    var location: Location?
    
    override func viewDidLoad() {
        let grTap = UITapGestureRecognizer(target: self, action: #selector(onMapTap(gestureRecognizer:)))
        mvMap.addGestureRecognizer(grTap)
        mvMap.delegate = self
//        if #available(iOS 11.0, *) {
//            mvMap.mapType = .mutedStandard
//        }
    }
    
    @objc func onMapTap(gestureRecognizer:UITapGestureRecognizer) {
        for annotation in self.mvMap.selectedAnnotations {
            self.mvMap.deselectAnnotation(annotation, animated: false)
        }
        mvMap.removeAnnotations(mvMap.annotations)
        mvMap.removeOverlays(mvMap.overlays)
        
        let touchPoint = gestureRecognizer.location(in: self.mvMap)
        let touchCoordinate = mvMap.convert(touchPoint, toCoordinateFrom: self.mvMap)
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchCoordinate

        self.location = Location(longitude: touchCoordinate.longitude, latitude: touchCoordinate.latitude)
    
        let circle = MKCircle(center: touchCoordinate,
                                      radius: 100000)
        self.mvMap.addOverlay(circle)
        
        self.mvMap.addAnnotation(annotation)
        self.mvMap.selectAnnotation(annotation, animated: true)
    }
    
    
    
    @IBAction func searchTapped(_ sender: Any) {
        if let location = self.location {
            presenter?.search(view: self, location: location)
        }
    }
}

extension PickLocationViewController: PickLocationPresenterDelegate {
    //Here would be messages from the Presenter to the View
    //Right now we don't have any
}

extension PickLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = .black
        circleRenderer.strokeColor = .red
        circleRenderer.alpha = 0.1

        return circleRenderer
    }
}

// MARK: - Hide Navigation Bar
extension PickLocationViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
