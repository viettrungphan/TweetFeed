//
//  TestRemoteFeedLoader.swift
//  TweetFeedTests
//
//  Created by MacOS on 23/01/2024.
//

import XCTest

final class TestRemoteFeedLoader: XCTestCase {
    func test_Init_RemoteFeedLoader_Success() {
        let feedLoader = self.makeSUT()
        XCTAssertNotNil(feedLoader)
    }
    
    func test_fetchFeed_Success() {
        let feedLoader = self.makeSUT()
        feedLoader.isSuccess = true
        let exp = self.expectation(description: "Expect load feed success")
        
        feedLoader.fetchFeed(onComplete: { result in
            switch result {
            case .success(let feed):
                XCTAssertNotNil(feed)
                exp.fulfill()
            case .failure(_):
                assert(true, "Should not fall here")
            }
        })
        self.wait(for: [exp], timeout: 1)
    }
    
    func test_fetchFeed_Failed() {
        let feedLoader = self.makeSUT()
        feedLoader.isSuccess = false
        let exp = self.expectation(description: "Expect load feed failed")
        
        feedLoader.fetchFeed(onComplete: { result in
            switch result {
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
        let network = NetworkTest()
        XCTAssertNotNil(network)
        
        let loader = RemoteFeedLoader(network: network)
        trackForMemoryLeaks(loader)
        return loader
    }
}
