//
//  GBIFManager.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import Foundation

class GBIFError: Error {
    
}

class GBIFManager {
    
    let config: URLSessionConfiguration
    let session: URLSession
    let api = "https://api.gbif.org/v1/"
    let method = "occurrence/search"
    var params = [
        "limit": "30",
        "basis_of_record": "HUMAN_OBSERVATION",
        "depth": "1,10",
        "taxon_key": "1",
        "has_coordinate":"true",
        "has_geospatial_issue":"false",
        "geometry": "POLYGON((151.85989%20-33.05702,152.46552%20-33.04781,152.46552%20-32.65094,152.03156%20-32.65094,151.85989%20-33.05702))"
    ]
//    let params = "occurrence/search?basis_of_record=HUMAN_OBSERVATION&depth=1,10&has_coordinate=true&has_geospatial_issue=false&taxon_key=1&advanced=1&geometry=POLYGON((151.85989%20-33.05702,152.46552%20-33.04781,152.46552%20-32.65094,152.03156%20-32.65094,151.85989%20-33.05702))"
    
    init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func getAnimals(coord:String, result: @escaping ([Animal], GBIFError) -> ()) -> Void {
        var urlString = api+method+"?"
        params.forEach({key, value in
            urlString += "\(key)=\(value)&"
        })
        
        let url = URL(string: urlString)!
        let task = session.dataTask(with: url) { data, response, error in
             guard error == nil else {
                print("error: \(error!)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            let response: GBIFResponse
            do {
                response = try JSONDecoder().decode(GBIFResponse.self, from: data)
            } catch let error {
                print(error)
                return
            }
            
            result(self.cleanResult(response), GBIFError())
        }
        task.resume()
    }
    
    func cleanResult(_ response:GBIFResponse) -> [Animal] {
        var result = [Animal]()
        
        let uniques = Array(Set(response.results))
        
        uniques.forEach({ occurence in
            result.append(Animal(family: occurence.vernacularName, risk: .edGreen))
        })
        
        return result
    }
}
