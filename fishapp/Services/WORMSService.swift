//
//  WORMSService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 02.11.20.
//

import Foundation

class WORMSService {
    
    static func getVernacular(id: Int, onResult: @escaping (String?) -> Void) {
        let url = "https://www.marinespecies.org/rest/AphiaVernacularsByAphiaID/\(id)"
        JSONWebservice.callWebservice(url: url, responseClass: [WORMSResponse].self, onError: {_ in
            onResult(nil)
        }, onResult: { response in
            onResult(self.getEnglishNameFromResponse(response: response))
        })
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
