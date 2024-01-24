//
//  TestLocalFeedLoader.swift
//  TweetFeedTests
//
//  Created by MacOS on 24/01/2024.
//

import XCTest

final class LocalFeedLoader {}

final class TestLocalFeedLoader: XCTestCase {
    func test_Init_Loader_Success() {
        let feedLoader = LocalFeedLoader()
        
        XCTAssertNotNil(feedLoader)
    }
}
