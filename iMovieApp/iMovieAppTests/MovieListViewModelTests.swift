//
//  MovieListViewModelTests.swift
//  iMovieAppTests
//
//  Created by Popilian Andrei on 11/10/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import XCTest
@testable import iMovieApp

class MovieListViewModelTests: XCTestCase {
  
  private var viewModel: MoviesListViewModel!
  
  override func setUp() {
    let movieWebService = Injector.injMovieWebService()
    viewModel = Injector.injMoviesListViewModel(movieWebService)
  }
  
  override func tearDown() {
    viewModel = nil
  }
  
  func testFetchMoviesAddMoviesToList() {
    viewModel.fetchMovies()
    sleep(3)
    
    XCTAssertTrue(viewModel.movieList.value?.count ?? 0 > 0)
  }
  
  func testFetchMoviesWithInvalidSearchReturn0Elements() {
    viewModel.fetchMovies("6666666")
    sleep(3)
    
    XCTAssertTrue(viewModel.movieList.value?.count ?? 0 == 0 )
  }
  
  func testFetchNextPageIncrementsThePage() {
    XCTAssert(viewModel.currentPage == 1)
    viewModel.fetchNextPage()
    sleep(3)
    
    XCTAssert(viewModel.currentPage == 2)
  }
  
  func testGetDetailVCReturnsValidViewController() {
    viewModel.fetchMovies()
    sleep(3)
    
    let vc = viewModel.getDetailVCForRow(1)
    XCTAssert(vc!.isKind(of: UIViewController.self))
  }
  
  func testGetDetailVCWithoutFetchingMoviesReturnsNil() {
    let vc = viewModel.getDetailVCForRow(1)
    XCTAssert(vc == nil)
  }
  
}
