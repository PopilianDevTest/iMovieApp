//
//  MovieDetailViewModel.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/9/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import UIKit

class MovieDetailViewModel {
  
  var movie: MovieResult
  private var imageWebService: ImageWebService!
  private var imageCache: NSCache<AnyObject, AnyObject>
  
  private let defaultImageW: Int = 500
  
  required init(_ movie: MovieResult,
                _ imageWebService: ImageWebService,
                _ imageCache: NSCache<AnyObject, AnyObject>) {
    
    self.movie = movie
    self.imageWebService = imageWebService
    self.imageCache = imageCache;
  }
  
  func getBackdropImage(completionHandler: @escaping ((UIImage?) -> Void)) {
    guard let url = movie.backdropPath else {
      completionHandler(nil)
      return
    }
    
    imageWebService.getImageWithUrl(url, imageWidth: defaultImageW, imageCache: imageCache) { (image) in
      guard let image = image else { return }
      completionHandler(image)
    }
  }
}
