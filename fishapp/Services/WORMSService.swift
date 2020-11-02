//
//  WORMSService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 02.11.20.
//

import Foundation

class WORMSService {
    
    static func getVernacular(id: Int, onResult: @escaping (String) -> Void) {
        let url = "https://www.marinespecies.org/rest/AphiaVernacularsByAphiaID/\(id)"
        
        JSONWebservice.callWebservice(url: url, responseClass: [WORMSResponse].self,onError: {print($0)}, onResult: { response in
            onResult(self.getEnglishNameFromResponse(response: response.first!)) //TODO: Get actual vernacular name from array of responses
        })
    }
    
    private static func getEnglishNameFromResponse(response: WORMSResponse) -> String {
        return "TODO"
    }
}
