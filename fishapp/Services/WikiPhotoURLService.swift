//
//  WikiPhotoURLService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 16.11.20.
//

import Foundation
import Feuerlib

class WikiPhotoURLService {
    
    static func getPhotoUrl(scientificName: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        
        let url = "https://en.wikipedia.org/w/api.php?action=query&redirects&prop=pageimages&format=json&piprop=original|thumbnail&titles=\(scientificName)"
        
        JSONWebservice.callWebservice(url: url, responseClass: WikiPhotoURLResult.self, completionHandler: { result in
            switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let result):
                    if let url = result.query.pages.values.first?.original?.source {
                        if(url.contains(".png") || url.contains(".jpg")) {
                            completionHandler(.success(url))
                        } else {
                            completionHandler(.failure(ServiceError.wrongFiletype))
                        }
                    } else {
                        completionHandler(.failure(ServiceError.noData))
                    }
            }
        })
    }
}

struct WikiPhotoURLResult: Decodable {
    
    var query: Query
    
    struct Query: Decodable {
        var pages: [String: Page]
    }
    
    struct Page: Decodable {
        var original: Image?
        var thumbnail: Image?
    }
    
    struct Image: Decodable {
        var source: String
    }
}


