//
//  LoadPhotoService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 22.11.20.
//

import UIKit
import Feuerlib

/**
 Service combines url cache of images and downloading 
 */
class LoadPhotoService {
    
    static func loadPhoto(id: Int, searchParameter: String, completionHandler: @escaping (CachableResult<Int, UIImage, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async() {
            //Step 1: Check in UserDefaults for url
            if let url = UserDefaults.standard.string(forKey: "photo-\(id)") {
                //Step 2: Check if family doesn't have photo
                if url == FAMILY_NO_PHOTO {
                    completionHandler(CachableResult(.failure(ServiceError.noData), id))
                } else {
                    //Download or load photo from Cache
                    ImageCache.shared.getImage(from: url) { result in
                        switch result.result {
                        case .success(let image):
                            completionHandler(CachableResult(.success(image), id))
                        case .failure(let error):
                            completionHandler(CachableResult(.failure(error), id))
                            break
                        }
                    }
                }
            } else {
                //Step 4: Never looked for Photo. Ask Wiki for it.
                WikiPhotoURLService.getPhotoUrl(scientificName: searchParameter, completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        if let serviceError = error as? ServiceError {
                            if serviceError == .noData || serviceError == .wrongFiletype {
                                //Animal has no photo on wiki or photo with wrong filetype
                                UserDefaults.standard.setValue(FAMILY_NO_PHOTO, forKey: "photo-\(id)")
                            }
                        }
                        completionHandler(CachableResult(.failure(error), id))
                    case .success(let url):
                        //Found url, now download or get from cache (might be the same photo as already loaded one)
                        UserDefaults.standard.setValue(url, forKey: "photo-\(id)")
                        
                        ImageCache.shared.getImage(from: url) { result in
                            switch result.result {
                            case .success(let image):
                                completionHandler(CachableResult(.success(image), id))
                            case .failure(let error):
                                completionHandler(CachableResult(.failure(error), id))
                                break
                            }
                        }
                    }
                })
            }
        }
    }
}
