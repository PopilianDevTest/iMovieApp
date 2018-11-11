//
//  ImageWebServiceTests.swift
//  iMovieAppTests
//
//  Created by Popilian Andrei on 11/10/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import XCTest
@testable import iMovieApp

class ImageWebServiceTests: XCTestCase {
  
  private var imageWebService: ImageWebService!
  private var validImageUrl: String!
  private var completedExpectation: XCTestExpectation!
  private var imageCache: NSCache<AnyObject, AnyObject>!
  
  override func setUp() {
    completedExpectation = expectation(description: "Completed")
    imageWebService = Injector.injImageWebService()
    validImageUrl = "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg"
    imageCache = NSCache<AnyObject, AnyObject>()
  }
  
  override func tearDown() {
    imageWebService = nil
    validImageUrl = nil
  }
  
  func testGetImageReturnsValidUIImage() {
    imageWebService.getImageWithUrl(validImageUrl, imageWidth: 200, imageCache: imageCache) { (image) in
      XCTAssert(image != nil)
      self.completedExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testGetImageCachesTheImage() {
    imageWebService.getImageWithUrl(validImageUrl, imageWidth: 200, imageCache: imageCache) { (image) in
      XCTAssert(image != nil)
      self.completedExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
    let image = imageCache.object(forKey: validImageUrl as AnyObject)
    XCTAssertTrue(image != nil)
  }
  
  func testGetImageWithInvalidImageWidthReturnsNoImage() {
    imageWebService.getImageWithUrl(validImageUrl, imageWidth: 9999, imageCache: imageCache) { (image) in
      XCTAssert(image == nil)
      self.completedExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
  }
  
  func testGetImageWithInvalidImageUrlReturnsNoImage() {
    imageWebService.getImageWithUrl("Error", imageWidth: 200, imageCache: imageCache) { (image) in
      XCTAssert(image == nil)
      self.completedExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 3, handler: nil)
  }
  
}
