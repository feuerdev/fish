//
//  WebService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 29.10.20.
//

import Foundation

protocol JSONWebserviceDelegate {
    func didSuccessfullyGetResponse<T: Decodable>(response: T)
    func didFailWithError(error:String)
    func updateStatus(_ status:String)
}

class JSONWebservice {
    
    static func callWebservice<T: Decodable>(url:String, responseClass: T.Type, delegate: JSONWebserviceDelegate) {
        let session = URLSession.shared
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let url = URL(string: encoded)!
        
        delegate.updateStatus("Calling Webservice...")
        
        let task = session.dataTask(with: url) { data, response, error in
            
            delegate.updateStatus("Handling Response...")
             guard error == nil else {
                delegate.didFailWithError(error: error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                delegate.didFailWithError(error: "No Data")
                return
            }
            
            let response: T
            do {
                delegate.updateStatus("Decoding Webservice Response...")
                response = try JSONDecoder().decode(responseClass, from: data)
            } catch let error {
                delegate.didFailWithError(error: error.localizedDescription)
                return
            }
            
            delegate.updateStatus("Cleaning up results...")
            delegate.didSuccessfullyGetResponse(response: response)
        }
        task.resume()
    }
}
