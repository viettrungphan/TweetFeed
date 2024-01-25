//
//  TestFallbackableFeedLoader.swift
//  TweetFeedTests
//
//  Created by MacOS on 25/01/2024.
//

import XCTest

final class FallbackableFeedLoader {
    
}

final class TestFallbackableFeedLoader: XCTestCase {
    func  test_Init_Success() {
        let feedLoader = FallbackableFeedLoader()
        XCTAssertNotNil(feedLoader)
    }
}
