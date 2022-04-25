//
//  WikiDescriptionService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 09.01.21.
//

import Foundation
import Feuerlib

class WikiDescriptionService {

    static func getDescription(searchTerm: String, completionHandler: @escaping (Result<String, Error>) -> Void) {

        let url = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=\(searchTerm)"

        JSONWebservice.callWebservice(url: url, responseClass: WikiDescriptionResult.self, completionHandler: { result in
            switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let result):
                    if let description = result.query.pages.values.first?.extract {
                        completionHandler(.success(description))
                    } else {
                        completionHandler(.failure(ServiceError.noData))
                    }
            }
        })
    }
}

struct WikiDescriptionResult: Decodable {

    var query: Query

    struct Query: Decodable {
        var pages: [String: Page]
    }

    struct Page: Decodable {
        var extract: String?
    }
}
