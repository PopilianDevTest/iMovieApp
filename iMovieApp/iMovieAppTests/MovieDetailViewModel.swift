//
//  MovieDetailViewModel.swift
//  iMovieAppTests
//
//  Created by Popilian Andrei on 11/10/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import XCTest
@testable import iMovieApp

class MovieDetailViewModel: XCTestCase {
  
  override func setUp() {
  }
  
  override func tearDown() {
  }
  
  func testGetBackdropImageWithValidMovieReturnsImage() {
    let imageWebService = Injector.injImageWebService()
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    let viewModel = Injector.injMovieDetailViewModel(Mocks.validMovie(), imageWebService, imageCache)
    let completedExpectation = expectation(description: "Completed")
    
    viewModel.getBackdropImage { (image) in
      XCTAssert(image != nil)
      completedExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testGetBackdropImageWithInvalidMovieImageReturnsNil() {
    let imageWebService = Injector.injImageWebService()
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    let viewModel = Injector.injMovieDetailViewModel(Mocks.invalidMovie(), imageWebService, imageCache)
    let completedExpectation = expectation(description: "Completed")
    
    viewModel.getBackdropImage { (image) in
      XCTAssert(image == nil)
      completedExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
  }
}
