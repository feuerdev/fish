//
//  LoadPhotoService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 22.11.20.
//

import Foundation

/**
 Service combines url cache of images and downloading 
 */
class LoadPhotoService {
    
    static func loadPhoto(id: Int, searchParameter: String, completionHandler: @escaping (Result<(taxonId:Int, url:String), Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async() {
            //Step 1: Check in UserDefaults for Image
            if let url = UserDefaults.standard.string(forKey: "photo-\(id)") {
                //Step 2: Check if family doesn't have photo
                if url == FAMILY_NO_PHOTO {
                    completionHandler(.failure(ServiceError.noData))
                } else {
                    completionHandler(.success((id, url)))
                }
            } else {
                //Step 4: Never looked for Photo. Ask Wiki for it.
                DispatchQueue.global(qos: .userInitiated).async() {
                        WikiPhotoURLService.getPhotoUrl(scientificName: searchParameter, completionHandler: { result in
                        switch result {
                        case .failure(let error):
                            if let serviceError = error as? ServiceError {
                                if serviceError == .noData || serviceError == .wrongFiletype {
                                    UserDefaults.standard.setValue(FAMILY_NO_PHOTO, forKey: "photo-\(id)")
                                }
                            }
                            completionHandler(.failure(error))
                        case .success(let url):
                            UserDefaults.standard.setValue(url, forKey: "photo-\(id)")
                            completionHandler(.success((id, url)))
                        }
                    })
                }
            }
        }
    }
}
