//
//  TestLocalFeedLoader.swift
//  TweetFeedTests
//
//  Created by MacOS on 24/01/2024.
//

import XCTest

final class LocalFeedLoader: FeedLoader {
    func fetchFeed(onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
        onComplete(.success([]))
    }
}

final class TestLocalFeedLoader: XCTestCase {
    func test_Init_Loader_Success() {
        let feedLoader = self.makeSUT()
        
        XCTAssertNotNil(feedLoader)
    }
    
    func test_Init_NewFeedLoader_ShouldReturn_EmptyFeed() {
        let feedLoader = self.makeSUT()
        
        let exp = self.expectation(description: "Expect Init new LocalFeedLoader should return an Empty feed")
        
        feedLoader.fetchFeed { result in
            switch result {
            case .success(let feed):
                let emtyFeedItem = 0
                XCTAssertTrue(feed.count == emtyFeedItem)
                exp.fulfill()
            case .failure(_):
                assert(true, "Should not fall here")
            }
        }
        self.wait(for: [exp], timeout: 1)
    }
}

extension TestLocalFeedLoader {
    func makeSUT() -> LocalFeedLoader {
        let feedLoader = LocalFeedLoader()
        return feedLoader
    }
}
