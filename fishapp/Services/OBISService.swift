//
//  GBIFManager.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import MapKit
import Foundation

#if DEBUG
let MAX_RESULTS = 30
#else
let MAX_RESULTS = 10000
#endif

class OBISService {

    static func getCheckList(location: Location,
                             radius: Double = 100000,
                             onStatus: @escaping (_ status: String) -> Void,
                             completionHandler: @escaping (Result<OBISResponse, Error>) -> Void) {
        let url = "https://api.obis.org/v3/checklist?size=\(MAX_RESULTS)&geometry=\(locationToPolygon(location, radius: radius))"

        JSONWebservice.callWebservice(url: url, responseClass: OBISResponse.self, onStatus: {
            onStatus($0)
        }) { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let response):
                completionHandler(.success(response))
            }
        }
    }

    static func locationToPolygon(_ location: Location, radius: CLLocationDistance) -> String {
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: radius, longitudinalMeters: radius)
        let latMin = region.center.latitude - 0.5 * region.span.latitudeDelta
        let latMax = region.center.latitude + 0.5 * region.span.latitudeDelta
        let lonMin = region.center.longitude - 0.5 * region.span.longitudeDelta
        let lonMax = region.center.longitude + 0.5 * region.span.longitudeDelta

        return "POLYGON((\(lonMin) \(latMin),\(lonMin) \(latMax),\(lonMax) \(latMax),\(lonMax) \(latMin), \(lonMin) \(latMin)))"
    }
}
