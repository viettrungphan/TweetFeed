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
    var isSuccess = false
    func fetchFeed(onComplete: (Result<[FeedItem], Error>)->Void) {
        if isSuccess {
            onComplete(.success([]))
        } else {
            onComplete(.failure(self.anyError()))
        }
    }
    
    func anyError() -> Error {
        Error.any
    }
}

enum Error: Swift.Error {
    case any
}

final class TestRemoteFeedLoader: XCTestCase {
    func test_Init_RemoteFeedLoader_Success() {
        let feedLoader = self.makeSUT()
        XCTAssertNotNil(feedLoader)
    }
    
    func test_fetchFeed_Success() {
        let feedLoader = self.makeSUT()
        feedLoader.isSuccess = true
        let exp = self.expectation(description: "Expect load feed success")
        
        feedLoader.fetchFeed(onComplete: { feed in
            XCTAssertNotNil(feed)
            exp.fulfill()
        })
        self.wait(for: [exp], timeout: 1)
    }
    
    func test_fetchFeed_Failed() {
        let feedLoader = self.makeSUT()
        feedLoader.isSuccess = false
        let exp = self.expectation(description: "Expect load feed failed")
        
        feedLoader.fetchFeed(onComplete: { feed in
            switch feed {
            case .failure(let error):
                XCTAssertNotNil(error)
                exp.fulfill()
            case .success(_):
                assert(true, "Should not fall here")
            }
        })
        self.wait(for: [exp], timeout: 1)
    }
}

extension TestRemoteFeedLoader {
    func makeSUT() -> RemoteFeedLoader {
        RemoteFeedLoader()
    }
}
