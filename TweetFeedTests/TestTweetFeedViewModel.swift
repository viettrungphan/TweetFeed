//
//  TestTweetFeedViewModel.swift
//  TweetFeedTests
//
//  Created by MacOS on 25/01/2024.
//

import XCTest

final class TestTweetFeedViewModel: XCTestCase {
    func test_Init_Should_Success() {
        let viewModel = self.makeSUT(feedLoader: self.emptyFeedLoader())
        XCTAssertNotNil(viewModel)
    }
    
    func test_LoadFeed_Success() {
        let viewModel = self.makeSUT(feedLoader: self.emptyFeedLoader())
        let exp = self.expectation(description: "Expect load feed success")
        
        viewModel.loadFeed(onComplete:{ result in
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
    
    func test_LoadFeed_Failed() {
        let viewModel = self.makeSUT(feedLoader: self.failedFeedLoader())
        let exp = self.expectation(description: "Expect load feed failed")
        
        viewModel.loadFeed(onComplete:{ result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(_):
                assert(true, "Should not fall here")
            }
            exp.fulfill()
        })
        
        self.wait(for: [exp], timeout: 1)
    }
}

//MARK: - Helper methods
extension TestTweetFeedViewModel {
    
    private enum TweetError: Error {
        case any
    }
    
    private class EmptyFeedLoader: FeedLoader {
        func fetchFeed(onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
            onComplete(.success([]))
        }
    }
    
    private class FailedFeedLoader: FeedLoader {
        func fetchFeed(onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
            onComplete(.failure(TweetError.any))
        }
    }
    
    func makeSUT(feedLoader:FeedLoader) -> TweetFeedViewModel {
        let viewModel = TweetFeedViewModel(feedLoader: feedLoader)
        return viewModel
    }
    
    func emptyFeedLoader() -> FeedLoader {
        EmptyFeedLoader()
    }
    
    func failedFeedLoader() -> FeedLoader {
        FailedFeedLoader()
    }
}
