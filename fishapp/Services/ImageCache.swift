//
//  ImageCache.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 30.11.20.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func getImage(from urlString:String, completionHandler: @escaping(Result<(cacheKey:String, image:UIImage), Error>) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completionHandler(.success((String(cacheKey), image)))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(ServiceError.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completionHandler(.failure(ServiceError.noData))
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completionHandler(.success((String(cacheKey), image)))
        }.resume()
    }
}
