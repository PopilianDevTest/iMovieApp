//
//  Mocks.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/10/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import Foundation

struct Mocks {
  
  static func validMovie() -> MovieResult {
    return MovieResult(title: "Venom",
                       posterPath: "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
                       backdropPath: "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
                       overview: "It's a movie")
  }
  
  static func invalidMovie() -> MovieResult{
    return MovieResult(title: "Venom",
                       posterPath: nil,
                       backdropPath: nil,
                       overview: nil)
  }
}
