//
//  TestRemoteFeedLoader.swift
//  TweetFeedTests
//
//  Created by MacOS on 23/01/2024.
//

import XCTest

struct FeedItem {
}

final class RemoteFeedLoader {
    func fetchFeed() -> [FeedItem] {
        return []
    }
}

final class TestRemoteFeedLoader: XCTestCase {
    func test_Init_RemoteFeedLoader_Success() {
        let feedLoader = RemoteFeedLoader()
        XCTAssertNotNil(feedLoader)
    }
    
    func test_fetchFeed_Success() {
        let feedLoader = RemoteFeedLoader()
        
        let feed = feedLoader.fetchFeed()
        XCTAssertNotNil(feed)
    }
}
