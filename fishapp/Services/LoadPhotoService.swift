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

    static func loadPhoto(id: Int, searchParameters: [String], completionHandler: @escaping (CachableResult<Int, UIImage, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async() {
            //Step 1: Check in UserDefaults for url
            if let url = UserDefaults.standard.string(forKey: "photourl-\(id)") {
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
            } else {
                //Step 4: Never looked for Photo. Ask Wiki for it.
                for param in searchParameters {
                    //Check if we found phot in a previous iteration
                    guard UserDefaults.standard.string(forKey: "photourl-\(id)") == nil else {
                        return
                    }
                    
                    let dgroup = DispatchGroup()
                    dgroup.enter()
                    WikiPhotoURLService.getPhotoUrl(scientificName: param, completionHandler: { result in
                        switch result {
                        case .failure(_):
                            dgroup.leave()
                            break
                        case .success(let url):
                            //Found url, now download or get from cache (might be the same photo as already loaded one)
                            ImageCache.shared.getImage(from: url) { result in
                                switch result.result {
                                case .success(let image):
                                    UserDefaults.standard.setValue(url, forKey: "photourl-\(id)")
                                    completionHandler(CachableResult(.success(image), id))
                                    dgroup.leave()
                                case .failure(_):
                                    dgroup.leave()
                                    break
                                }
                            }
                        }
                    })
                    dgroup.wait()
                }
                //After all the search parameters have been tried, check if still no image was found.
                let url = UserDefaults.standard.string(forKey: "photourl-\(id)")

                guard url == nil else {
                    return
                }
                
                completionHandler(CachableResult(.failure(ServiceError.noData), id))
            }
        }
    }
}
