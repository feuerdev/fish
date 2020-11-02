//
//  GBIFManager.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import MapKit
import Foundation

#if DEBUG
let MAX_RESULTS = 10
#else
let MAX_RESULTS = 10000
#endif

class OBISService {
    
    static func getCheckList(location: Location, onStatus: @escaping (_ status: String) -> Void, onResult: @escaping ([Animal]?, String?/* TODO: This should be an Error type*/) -> Void) {
        
        let url = "https://api.obis.org/v3/checklist?size=\(MAX_RESULTS)&geometry=\(locationToPolygon(location))"
        
        JSONWebservice.callWebservice(url: url, responseClass: OBISResponse.self, onStatus: {
            onStatus($0)
        }, onError: { error in
            onResult(nil, error)
        }, onResult: { response in
            onResult(self.cleanResult(response), nil)
        })
    }
    static func cleanResult(_ response:OBISResponse) -> [Animal] {
        var result = [Animal]()
        
        let uniques = Array(Set(response.results))
        
        uniques.forEach({ species in
            result.append(Animal(family: species.family, familyID: species.familyid, category: .edGreen))
        })
        print(result.count)
        
        return result.sorted {
            $0.family ?? "None" < $1.family ?? "None"
        }
    }
    
    static func locationToPolygon(_ location:Location) -> String {
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100000, longitudinalMeters: 100000)
        let latMin = region.center.latitude - 0.5 * region.span.latitudeDelta
        let latMax = region.center.latitude + 0.5 * region.span.latitudeDelta
        let lonMin = region.center.longitude - 0.5 * region.span.longitudeDelta
        let lonMax = region.center.longitude + 0.5 * region.span.longitudeDelta
        
        return "POLYGON((\(lonMin) \(latMin),\(lonMin) \(latMax),\(lonMax) \(latMax),\(lonMax) \(latMin), \(lonMin) \(latMin)))"
    }
}
