//
//  TestRemoteFeedLoader.swift
//  TweetFeedTests
//
//  Created by MacOS on 23/01/2024.
//

import XCTest

final class RemoteFeedLoader {
    
}

final class TestRemoteFeedLoader: XCTestCase {
    func test_Init_RemoteFeedLoader_Success() {
        let feedLoader = RemoteFeedLoader()
        XCTAssertNotNil(feedLoader)
    }
}
