//
//  TestTweetFeedViewModel.swift
//  TweetFeedTests
//
//  Created by MacOS on 25/01/2024.
//

import XCTest

final class TweetFeedViewModel {
    
}

final class TestTweetFeedViewModel: XCTestCase {
    func test_Init_Should_Success() {
        let viewModel = TweetFeedViewModel()
        XCTAssertNotNil(viewModel)
    }
}
