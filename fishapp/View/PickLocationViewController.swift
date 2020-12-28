//
//  PickByMapViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 27.10.20.
//
import UIKit
import MapKit
import Feuerlib

class PickLocationViewController : UIViewController {
    
    @IBOutlet weak var sbLocation: UISearchBar!
    @IBOutlet weak var mvMap: MKMapView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tvLocationResults: UITableView!
    @IBOutlet weak var conSearchbarTop: NSLayoutConstraint!
    @IBOutlet weak var conResultHeight: NSLayoutConstraint!
    var presenter: PickLocationPresenter?
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [String]()
    
    var location: Location?
    
    override func viewDidLoad() {
        self.title = getAppName()

        if #available(iOS 11.0, *) {
            //nothing
        } else {
            conSearchbarTop.constant = 44
        }
        
        sbLocation.setTextColor(textTintColor)
        sbLocation.setSearchIconColor(textTintColor)
        sbLocation.backgroundColor = .clear
        sbLocation.tintColor = textTintColor
        sbLocation.placeholder = "Search Location"
        sbLocation.delegate = self
        sbLocation.setTextField(color: backGroundColor)
        sbLocation.getTextField()?.layer.cornerRadius = defaultCornerRadius
        sbLocation.layer.cornerRadius = defaultCornerRadius
        
        sbLocation.setPlaceholderTextColor(placeHolderColor)
        
        tvLocationResults.backgroundColor = backGroundColor
        tvLocationResults.layer.cornerRadius = defaultCornerRadius
        tvLocationResults.dataSource = self
        tvLocationResults.delegate = self

        let grTap = UITapGestureRecognizer(target: self, action: #selector(onMapTap(gestureRecognizer:)))
        mvMap.addGestureRecognizer(grTap)
        mvMap.delegate = self
        mvMap.mapType = .hybrid
        
        btnSearch.backgroundColor = tintColor
        btnSearch.setTitleColor(textTintColor, for: .normal)
        btnSearch.layer.cornerRadius = defaultCornerRadius
        
        searchCompleter.delegate = self
        searchCompleter.filterType = .locationsOnly
        if #available(iOS 13.0, *) {
            searchCompleter.pointOfInterestFilter = .excludingAll
        }
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
        } else {
            showToast(message: "Tap the map to select a location 🦈")
        }
    }
    
    func updateResultHeight() {
        self.tvLocationResults.reloadData()
        self.conResultHeight.constant = self.tvLocationResults.contentSize.height
        self.tvLocationResults.layoutIfNeeded()
    }
    
    func clearLocationSearch() {
        self.sbLocation.text = ""
        self.sbLocation.endEditing(true)
        self.sbLocation.setShowsCancelButton(false, animated: true)
        self.searchResults = []
        self.updateResultHeight()
    }
    
    func selectLocation(_ row:Int) {
        guard let query = self.searchResults[safe: row] else {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        self.clearLocationSearch()
        self.updateResultHeight()
        
        MKLocalSearch(request: request).start { (response, error) in
            guard let response = response,
                  let item = response.mapItems[safe: 0] else {
                self.showSimpleError(title: "Oops 🐙", message: error?.localizedDescription, popViewController: false)
                return
            }
            
            self.mvMap.centerCoordinate = item.placemark.coordinate
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        circleRenderer.fillColor = circleFillColor
        circleRenderer.strokeColor = circleStrokeColor
        circleRenderer.alpha = 0.1

        return circleRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if #available(iOS 11.0, *) {
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
            annotationView.markerTintColor = pinColor
                return annotationView
        } else {
            return mapView.view(for: annotation)
        }
    }
}

extension PickLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 0 else {
            return
        }
        
        self.searchCompleter.queryFragment = searchText
        
        self.sbLocation.setShowsCancelButton(searchText.count > 0, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.selectLocation(0)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.clearLocationSearch()
    }
}

extension PickLocationViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results.filter { (completion) -> Bool in
            let numbersRange = completion.title.rangeOfCharacter(from: .decimalDigits)
            return numbersRange == nil
        }.map { (completion) -> String in
            return completion.title
        }
        self.updateResultHeight()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.showSimpleError(title: "Oops 🐙", message: error.localizedDescription, popViewController: false)
    }
}
extension PickLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = textTintColor
        cell.textLabel?.text = self.searchResults[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
}

extension PickLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectLocation(indexPath.row)
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
