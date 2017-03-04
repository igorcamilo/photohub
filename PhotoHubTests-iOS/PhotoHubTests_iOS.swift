//
//  PhotoHubTests_iOS.swift
//  PhotoHubTests-iOS
//
//  Created by Igor Camilo on 04/03/17.
//
//

import XCTest
@testable import PhotoHub_iOS

class PhotoHubTests_iOS: XCTestCase {
  
  private let viewModel = PostsViewModel()
  
  func testUpdate() {
    
    let updateExpectation = expectation(description: "Update")
    
    viewModel.update { [weak self] (result) in
      switch result {
      case .success(_):
        let viewModel = self?.viewModel
        XCTAssertNotNil(viewModel?.forumHeader, "Forum header info is nil")
        XCTAssertEqual(viewModel?.forumHeader?.slug, "photography", "Slug doesn't match")
        XCTAssertGreaterThan(viewModel!.numberOfPosts, 0, "Number of posts is zero")
        XCTAssertNotNil(viewModel?.postHeader(section: 0), "Post info is nil")
        updateExpectation.fulfill()
      case .failure(let error):
        XCTAssert(false, "Update failed with error: \(error)")
      }
    }
    
    waitForExpectations(timeout: 30)
  }
}
