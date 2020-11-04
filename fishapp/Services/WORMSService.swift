//
//  WORMSService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 02.11.20.
//

import Foundation

class WORMSService {
    
    static func getVernacular(id: Int,
                              completionHandler: @escaping (Result<String, Error>) -> Void) {
        let url = "https://www.marinespecies.org/rest/AphiaVernacularsByAphiaID/\(id)"
        JSONWebservice.callWebservice(url: url, responseClass: [WORMSResponse].self) { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let response):
                let result = self.getEnglishNameFromResponse(response: response)
                if result != nil {
                    completionHandler(.success(result!))
                } else {
                    completionHandler(.failure(ServiceError.noData))
                }
            }
        }
    }
    
    private static func getEnglishNameFromResponse(response: [WORMSResponse]) -> String? {
        for item in response {
            if item.language_code == "eng" {
                return item.vernacular!.capitalized
            }
        }
        return nil
    }
}
