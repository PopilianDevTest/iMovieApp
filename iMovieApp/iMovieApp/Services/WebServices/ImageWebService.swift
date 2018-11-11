//
//  ImageWebService.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/8/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import UIKit

class ImageWebService {
  
  func getImageWithUrl(_ url: String,
                       imageWidth: Int,
                       imageCache: NSCache<AnyObject, AnyObject>,
                       completionHandler: @escaping ((UIImage?) -> Void)) {
    
    let fullUrl = getImageUrl(url, imageWidth)
    
    URLSession.shared.dataTask(with: fullUrl) { data, response, error in
      
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      if let data = data {
        DispatchQueue.global(qos: .userInitiated).async {
          let imageToCache = UIImage(data: data)
          guard let rImageToCache = imageToCache else
          {
            completionHandler(nil)
            return
          }
          
          imageCache.setObject(rImageToCache, forKey: url as AnyObject)
          completionHandler(imageToCache)
        }
      }
      }.resume()
  }
}

//MARK: - Private
private extension ImageWebService {
  func getImageUrl(_ url: String, _ imageWidth: Int) -> URL {
    return URL(string:"\(MovieApi.ImageUrl)w\(imageWidth)\(url)")!
  }
}
