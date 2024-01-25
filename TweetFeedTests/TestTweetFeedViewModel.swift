//
//  TestTweetFeedViewModel.swift
//  TweetFeedTests
//
//  Created by MacOS on 25/01/2024.
//

import XCTest

final class TweetFeedViewModel {
    func loadFeed(onSuccess: ([FeedItem]) -> Void) {
        onSuccess([])
    }
}

final class TestTweetFeedViewModel: XCTestCase {
    func test_Init_Should_Success() {
        let viewModel = TweetFeedViewModel()
        XCTAssertNotNil(viewModel)
    }
    
    func test_LoadFeed_Success() {
        let viewModel = TweetFeedViewModel()
        
        let exp = self.expectation(description: "Expect load feed success")
        
        viewModel.loadFeed(onSuccess:{ feed in
            XCTAssertNotNil(feed)
            exp.fulfill()
        })
        
        self.wait(for: [exp], timeout: 1)
    }
}
