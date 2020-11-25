//
//  LoadPhotoService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 22.11.20.
//

import Foundation

class LoadPhotoService {
    
    static func loadPhoto(id: String, searchParameter: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            //Step 1: Check in UserDefaults for Image
            if let fileName = UserDefaults.standard.string(forKey: id) {
                //Step 2: Check if family doesn't have photo
                if fileName == FAMILY_NO_PHOTO {
                    completionHandler(.failure(ServiceError.noData))
                } else {
                    completionHandler(.success(fileName))
                }
            } else {
                //Step 4: Never looked for Photo. Ask Wiki for it.
                WikiPhotoURLService.getPhotoUrl(scientificName: searchParameter, completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        UserDefaults.standard.setValue(FAMILY_NO_PHOTO, forKey: id)
                        completionHandler(.failure(error))
                    case .success(let url):
                        //Step 5: Download and save the photo in Documents
                        
                        guard let url = URL(string: url) else {
                            completionHandler(.failure(ServiceError.noData))
                            return
                        }
                        
                        guard let data = try? Data(contentsOf: url) else {
                            completionHandler(.failure(ServiceError.noData))
                            return
                        }
                       
                        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        let fileUrl = documents.appendingPathComponent(url.lastPathComponent)
                        do {
                            try data.write(to: fileUrl)
                            let fileName = fileUrl.lastPathComponent
                            UserDefaults.standard.setValue(fileName, forKey: id)
                            completionHandler(.success(fileName))
                        } catch(_) {
                            completionHandler(.failure(ServiceError.couldNotWrite))
                        }
                    }
                })
            }
        }
    }
}
