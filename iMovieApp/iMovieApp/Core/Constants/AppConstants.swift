//
//  ApiConstants.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/8/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import Foundation

struct MovieApi {
  
  static let AuthKey: String = "5573190c0baecffc729ed97dc3589b10"
  
  static let BaseUrl: String = "https://api.themoviedb.org/3/"
  
  static let NowPlayingUrl: String = "movie/now_playing"
  
  static let SearchUrl: String = "search/movie"
  
  static let ImageUrl: String = "https://image.tmdb.org/t/p/"
  
}

enum CellIdentifier: String {
  case MovieCell = "MovieCellIdentifier"
}
