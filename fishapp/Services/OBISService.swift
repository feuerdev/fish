//
//  GBIFManager.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import MapKit
import Foundation

protocol OBISServiceDelegate {
    func didSuccessfullyReturn(_ animals:[Animal])
    func didFailWithError(_ error:String)
    func updateStatus(_ status:String)
}

class OBISService {
    
    var delegate: OBISServiceDelegate?

    func getChecklist(location:Location, delegate: OBISServiceDelegate) -> Void  {
        
        self.delegate = delegate
        let api = "https://api.obis.org/v3/"
        let method = "checklist"
        let params = [
            "size": "10000",
            "geometry": locationToPolygon(location)
        ]
        var urlString = api+method+"?"
        params.forEach({key, value in
            urlString += "\(key)=\(value)&"
        })
        
        JSONWebservice.callWebservice(url: urlString, responseClass: OBISResponse.self, delegate: self)
    }
    
    func cleanResult(_ response:OBISResponse) -> [Animal] {
        var result = [Animal]()
        
        let uniques = Array(Set(response.results))
        
        uniques.forEach({ species in
            result.append(Animal(family: species.family, category: .edGreen))
        })
        print(result.count)
        
        return result.sorted {
            $0.family ?? "None" < $1.family ?? "None"
        }
    }
    
    func locationToPolygon(_ location:Location) -> String {
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100000, longitudinalMeters: 100000)
        let latMin = region.center.latitude - 0.5 * region.span.latitudeDelta
        let latMax = region.center.latitude + 0.5 * region.span.latitudeDelta
        let lonMin = region.center.longitude - 0.5 * region.span.longitudeDelta
        let lonMax = region.center.longitude + 0.5 * region.span.longitudeDelta
        
        return "POLYGON((\(lonMin) \(latMin),\(lonMin) \(latMax),\(lonMax) \(latMax),\(lonMax) \(latMin), \(lonMin) \(latMin)))"
    }
}

extension OBISService: JSONWebserviceDelegate {
    func didSuccessfullyGetResponse<T>(response: T) where T : Decodable {
        delegate?.didSuccessfullyReturn(cleanResult(response as! OBISResponse))
    }
    
    func didFailWithError(error: String) {
        //
    }
    
    func updateStatus(_ status: String) {
        //
    }
}
