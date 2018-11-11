//
//  MovieResult.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/8/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import Foundation


//used resultObject as Model, as we didn't use any persistance
//mapping to another same object will be an overkill
struct MoviesResult: Decodable {
  let results: [MovieResult]
  
  enum CodingKeys: String, CodingKey {
    case results
  }
}

struct MovieResult: Decodable {
  let title: String
  let posterPath: String?
  let backdropPath: String?
  let overview: String?
  
  enum CodingKeys: String, CodingKey {
    case title
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case overview
  }
}
