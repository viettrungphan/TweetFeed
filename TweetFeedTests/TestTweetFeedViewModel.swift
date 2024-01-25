//
//  TestTweetFeedViewModel.swift
//  TweetFeedTests
//
//  Created by MacOS on 25/01/2024.
//

import XCTest

enum TweetError: Error {
    case any
}

final class TweetFeedViewModel {
    var mockIsSuccess = false
    func loadFeed(onComplete: (Result<[FeedItem], Error>) -> Void) {
        if mockIsSuccess {
            onComplete(.success([]))
        } else {
            onComplete(.failure(TweetError.any))
        }
    }
}

final class TestTweetFeedViewModel: XCTestCase {
    func test_Init_Should_Success() {
        let viewModel = self.makeSUT()
        XCTAssertNotNil(viewModel)
    }
    
    func test_LoadFeed_Success() {
        let viewModel = TweetFeedViewModel()
        viewModel.mockIsSuccess = true
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
        let viewModel = self.makeSUT()
        viewModel.mockIsSuccess = false
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

extension TestTweetFeedViewModel {
    func makeSUT() -> TweetFeedViewModel {
        let viewModel = TweetFeedViewModel()
        return viewModel
    }
}
