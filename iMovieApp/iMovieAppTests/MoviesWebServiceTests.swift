//
//  MoviesWebServiceTests.swift
//  iMovieAppTests
//
//  Created by Popilian Andrei on 11/10/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import XCTest
@testable import iMovieApp

class MoviesWebServiceTests: XCTestCase {
  
  private var moviesWebService: MoviesWebService!
  
  override func setUp() {
    moviesWebService = Injector.injMovieWebService()
  }
  
  override func tearDown() {
    moviesWebService = nil
  }
  
  func testGetMoviesReturns20Elements() {
    let completedExpectation = expectation(description: "Completed")
    
    moviesWebService.getMoviesForPage(1, searchText: "") { (movies, isSuccess) in
      
      XCTAssertTrue(isSuccess)
      XCTAssert(movies != nil)
      XCTAssert(movies?.count == 20)
      
      completedExpectation.fulfill()
    }
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testGetMoviesForInvalidSearchReturns0Elements() {
    let completedExpectation = expectation(description: "Completed")
    
    moviesWebService.getMoviesForPage(1, searchText: "/////@@@?/") { (movies, isSuccess) in
      XCTAssertTrue(isSuccess)
      XCTAssert(movies != nil)
      XCTAssert(movies?.count == 0)
      
      completedExpectation.fulfill()
    }
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testGetMoviesForDifferentPagesDifferentElements() {
    var moviesPage1: [MovieResult]?
    let moviesPage1Exp = expectation(description: "MoviesPage1 Completed")
    moviesWebService.getMoviesForPage(1, searchText: "") { (movies, isSuccess) in
      XCTAssertTrue(isSuccess)
      XCTAssert(movies?.count ?? 0 > 0)
      moviesPage1 = movies
      
      moviesPage1Exp.fulfill()
    }
    
    var moviesPage2: [MovieResult]?
    let moviesPage2Exp = expectation(description: "MoviesPage2 Completed")
    moviesWebService.getMoviesForPage(2, searchText: "") { (movies, isSuccess) in
      XCTAssertTrue(isSuccess)
      XCTAssert(movies?.count ?? 0 > 0)
      moviesPage2 = movies
      
      moviesPage2Exp.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
    XCTAssertTrue(moviesPage1?.first?.title != moviesPage2?.first?.title, "First elements aren't the same")
  }
  
}
