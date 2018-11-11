//
//  MoviesListViewModel.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/8/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import RxSwift

class MoviesListViewModel {
  
  private var movieWebService: MoviesWebService!
  lazy var imageCache = NSCache<AnyObject, AnyObject>()
  
  var movieList: Variable<[MovieResult]?>!
  var isFetching: Bool = false
  var currentPage: Int = 1
  var searchText: String = ""
  
  required init(movieWebService: MoviesWebService) {
    self.movieWebService = movieWebService
    movieList = Variable<[MovieResult]?>(nil)
  }
  
  func fetchMovies(_ searchText: String = "") {
    resetMovieList()
    self.searchText = searchText
    
    movieWebService.getMoviesForPage(currentPage, searchText: searchText) { [weak self] (movies, isSuccess) in
      guard let `self` = self else { return }
      
      if isSuccess,
        let movies = movies {
        self.movieList.value = movies
      }
    }
  }
  
  func fetchNextPage() {
    currentPage += 1
    isFetching = true
    movieWebService.getMoviesForPage(currentPage, searchText: searchText) { [weak self] (movies, isSuccess) in
      guard let `self` = self else { return }
      
      if isSuccess,
        let movies = movies {
        self.movieList.value?.append(contentsOf: movies)
      }
    }
  }
  
  func getDetailVCForRow(_ row: Int) -> MovieDetailViewController? {
    guard movieList.value?.count ?? 0 > 0 else { return nil }
    
    let detailVC = MovieDetailViewController.storyboardViewController(AppStoryboard.Movies.instance)
    let imageWebService = Injector.injImageWebService()
    let detailVM = Injector.injMovieDetailViewModel(movieList.value![row], imageWebService, imageCache)
    
    detailVC.viewModel = detailVM
    return detailVC
  }
}

private extension MoviesListViewModel {
  func resetMovieList() {
    currentPage = 1
    movieList.value = nil
  }
}

