//
//  LoadPhotoService.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 22.11.20.
//

import Foundation

class LoadPhotoService {
    
    static func loadPhoto(id: String, searchParameter: String, completionHandler: @escaping (Result<String, ServiceError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            //Step 1: Check in UserDefaults for Image
            if let fileName = UserDefaults.standard.string(forKey: id) {
                //Step 2: Check if family doesn't have photo
                if fileName == FAMILY_NO_PHOTO {
                    completionHandler(.failure(.noData))
                } else {
                    completionHandler(.success(fileName))
                }
            } else {
                //Step 4: Never looked for Photo. Ask Wiki for it.
                WikiPhotoURLService.getPhotoUrl(scientificName: searchParameter, completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        if error as! ServiceError == ServiceError.noData {
                            UserDefaults.standard.setValue(FAMILY_NO_PHOTO, forKey: id)
                            completionHandler(.failure(.noData))
                        }
                    case .success(let url):
                        //Step 5: Download and save the photo in Documents
                        if let url = URL(string: url) {
                            if let data = try? Data(contentsOf: url) {
                                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                                let fileUrl = documents.appendingPathComponent(url.lastPathComponent)
                                do {
                                    try data.write(to: fileUrl)
                                    let fileName = fileUrl.lastPathComponent
                                    UserDefaults.standard.setValue(fileName, forKey: id)
                                    completionHandler(.success(fileName))
                                } catch(_) {
                                    completionHandler(.failure(.couldNotWrite))
                                }
                            }
                        }
                    }
                })
            }
        }
    }
}
