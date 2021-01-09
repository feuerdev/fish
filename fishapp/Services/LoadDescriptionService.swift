//
//  LoadDescriptionService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 09.01.21.
//

import Foundation
import Feuerlib

class LoadDescriptionService {
    
    static func loadDescription(id: Int, searchTerm: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            //Step 1: Check in UserDefaults for Image
            if let description = UserDefaults.standard.string(forKey: "description-\(id)") {
                //Step 2: Check if family doesn't have vernacular
                if description == FAMILY_NO_DESCRIPTION {
                    completionHandler(.failure(ServiceError.noData))
                } else {
                    completionHandler(.success(description))
                }
            } else {
                //Step 4: Never looked for Description -> Ask Wiki
                WikiDescriptionService.getDescription(searchTerm: searchTerm, completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        if error as? ServiceError == ServiceError.noData {
                            UserDefaults.standard.setValue(FAMILY_NO_DESCRIPTION, forKey: "description-\(id)")
                        }
                        completionHandler(.failure(error))
                    case .success(let name):
                        UserDefaults.standard.setValue(name, forKey: "description-\(id)")
                        completionHandler(.success(name))
                    }
                })
            }
        }
    }
}
