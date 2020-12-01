//
//  WebService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 29.10.20.
//

import Foundation
import Feuerlib

class JSONWebservice {
    
    static func callWebservice<T: Decodable>(url:String,
                                             responseClass: T.Type,
                                             onStatus: @escaping (String) -> Void = { _ in },
                                             completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            completionHandler(.failure(ServiceError.badUrl))
            return
        }
        guard let url = URL(string: encoded) else {
            completionHandler(.failure(ServiceError.badUrl))
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(ServiceError.noData))
                return
            }
            
            onStatus("Parsing Response")
            if let response: T = try? JSONDecoder().decode(T.self, from: data) {
                completionHandler(.success(response))
            } else {
                completionHandler(.failure(ServiceError.parserError))
            }
        }).resume()
        onStatus("Request sent")
    }
}
