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
    func fetchFeed(onSuccess: ([FeedItem])->Void) {
        onSuccess([])
    }
}

final class TestRemoteFeedLoader: XCTestCase {
    func test_Init_RemoteFeedLoader_Success() {
        let feedLoader = self.makeSUT()
        XCTAssertNotNil(feedLoader)
    }
    
    func test_fetchFeed_Success() {
        let feedLoader = self.makeSUT()
        
        let exp = self.expectation(description: "Expect load feed success")
        
        feedLoader.fetchFeed(onSuccess: { feed in
            XCTAssertNotNil(feed)
            exp.fulfill()
        })        
        self.wait(for: [exp], timeout: 1)
    }
}

extension TestRemoteFeedLoader {
    func makeSUT() -> RemoteFeedLoader {
        RemoteFeedLoader()
    }
}
