//
//  WebService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 29.10.20.
//

import Foundation

class JSONWebservice {
    
    static func callWebservice<T: Decodable>(url:String, responseClass: T.Type, onStatus: @escaping (String)->Void = {_ in }, onError: @escaping (String)->Void = {_ in}, onResult: @escaping (T)->Void) -> Void {
        
        guard let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            onError("Can't encode URL: \(url)")
            return
        }
        guard let url = URL(string: encoded) else {
            onError("Can't encode URL: \(encoded)")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                onError("No Data: \(url)")
                return
            }
            
            let response: T
            do {
                onStatus("Parsing Response")
                response = try JSONDecoder().decode(T.self, from: data)
                onResult(response)
            } catch let error {
                onError(error.localizedDescription)
                return
            }
        }).resume()
        onStatus("Request sent")
    }
}
