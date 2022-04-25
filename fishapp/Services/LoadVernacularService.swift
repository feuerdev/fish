//
//  LoadVernacularService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 25.11.20.
//

import Foundation
import Feuerlib

class LoadVernacularService {

    static func loadVernacular(id: Int, completionHandler: @escaping (CachableResult<Int, String, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {

            if let exception = exceptionVernacular(id: id) {
                completionHandler(CachableResult(.success(exception), id))
                return
            }

            // Check in UserDefaults for Image
            if let name = UserDefaults.standard.string(forKey: "vernacular-\(id)") {
                // Step 2: Check if family doesn't have vernacular
                if name == FAMILY_NO_VERNACULAR {
                    completionHandler(CachableResult(.failure(ServiceError.noData), id))
                } else {
                    completionHandler(CachableResult(.success(name), id))
                }
            } else {
                // Step 4: Never looked for Vernacular. Ask Worms for it.
                WORMSService.getVernacular(id: id, completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        if error as? ServiceError == ServiceError.noData {
                            UserDefaults.standard.setValue(FAMILY_NO_VERNACULAR, forKey: "vernacular-\(id)")
                        }
                        completionHandler(CachableResult(.failure(error), id))
                    case .success(let name):
                        UserDefaults.standard.setValue(name, forKey: "vernacular-\(id)")
                        completionHandler(CachableResult(.success(name), id))
                    }
                })
            }
        }
    }

    static func exceptionVernacular(id: Int) -> String? {
        switch id {
        case 105702: // Family of Great White Sharks, people have been complaining when the "Great white Shark was categorized as Yellow"
            return "Mackerel Sharks"
        case 105838: // Defaulted to "Anchovie Eater" which is weird
            return "Great White Shark"
        default:
            return nil
        }
    }
}
