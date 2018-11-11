//
//  InjectionConstants.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/8/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import Foundation

struct Injector {
  
  static func injMoviesListViewModel(_ movieWebService: MoviesWebService) -> MoviesListViewModel {
    return MoviesListViewModel(movieWebService: movieWebService)
  }
  
  static func injMovieWebService() -> MoviesWebService {
    return MoviesWebService()
  }
  
  static func injImageWebService() -> ImageWebService {
    return ImageWebService()
  }
  
  static func injMovieDetailViewModel(_ movie: MovieResult,
                                      _ imageWebService: ImageWebService,
                                      _ imageCache: NSCache<AnyObject, AnyObject>) -> MovieDetailViewModel {
    return MovieDetailViewModel(movie, imageWebService, imageCache)
  }
}

