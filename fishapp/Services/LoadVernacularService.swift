//
//  LoadVernacularService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 25.11.20.
//

import Foundation

class LoadVernacularService {
    
    static func loadVernacular(id: Int, completionHandler: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            //Step 1: Check in UserDefaults for Image
            if let fileName = UserDefaults.standard.string(forKey: "vernacular-\(id)") {
                //Step 2: Check if family doesn't have vernacular
                if fileName == FAMILY_NO_VERNACULAR {
                    completionHandler(.failure(ServiceError.noData))
                } else {
                    completionHandler(.success(fileName))
                }
            } else {
                //Step 4: Never looked for Photo. Ask Wiki for it.
                WORMSService.getVernacular(id: id, completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        UserDefaults.standard.setValue(FAMILY_NO_VERNACULAR, forKey: "vernacular-\(id)")
                        completionHandler(.failure(error))
                    case .success(let name):
                        completionHandler(.success(name))
                    }
                })
            }
        }
    }
}
