//
//  MoviesWebService.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/8/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import Foundation

class MoviesWebService {
  
  let defaultSession = URLSession(configuration: .default)
  var dataTask: URLSessionDataTask?
  
  func getMoviesForPage(_ pageNr: Int,
                        searchText: String,
                        completionHandler: @escaping ((_ movies: [MovieResult]?, _ succesfull: Bool) -> Void)) {
    
    let url = getMoviesUrlForPage(pageNr, searchText: searchText)
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print(error.localizedDescription)
        completionHandler(nil, false)
        return
      }
      
      guard let data = data else {
        completionHandler(nil, false)
        return
      }
      
      do {
        let movies = try JSONDecoder().decode(MoviesResult.self, from: data)
        completionHandler(movies.results, true)
      } catch let error  {
        print(error.localizedDescription)
        completionHandler(nil, false)
        return
      }
      }.resume()
  }
}

private extension MoviesWebService {
  func getMoviesUrlForPage(_ pageNr: Int, searchText: String) -> URL  {
    if searchText.isEmpty {
      return URL(string: "\(MovieApi.BaseUrl)\(MovieApi.NowPlayingUrl)?api_key=\(MovieApi.AuthKey)&page=\(pageNr)")!
    }
    return URL(string: "\(MovieApi.BaseUrl)\(MovieApi.SearchUrl)?query=\(searchText)&api_key=\(MovieApi.AuthKey)&page=\(pageNr)")!
  }
}

