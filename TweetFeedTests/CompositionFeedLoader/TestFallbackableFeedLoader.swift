//
//  TestFallbackableFeedLoader.swift
//  TweetFeedTests
//
//  Created by MacOS on 25/01/2024.
//

import XCTest


final class FallbackableFeedLoader: FeedLoader {
    
    init(primaryFeedLoader: FeedLoader, fallbackFeedLoader: FeedLoader) {
        self.primaryFeedLoader = primaryFeedLoader
        self.fallbackFeedLoader = fallbackFeedLoader
    }
    
    private let primaryFeedLoader:FeedLoader
    private let fallbackFeedLoader:FeedLoader
   
    func fetchFeed(onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
        self.primaryFeedLoader.fetchFeed { result in
            switch result {
            case .success(let feed):
                onComplete(.success(feed))
            case .failure(_):
                self.fallbackFeedLoader.fetchFeed(onComplete: onComplete)
            }
        }
    }
}

extension FeedLoader {
    func fallback(_ fallback: FeedLoader) -> FallbackableFeedLoader {
        FallbackableFeedLoader(primaryFeedLoader: self, fallbackFeedLoader: fallback)
    }
}

final class TestFallbackableFeedLoader: XCTestCase {
    func  test_Init_Success() {
        let feedLoader = FallbackableFeedLoader(primaryFeedLoader: self.anyFeedLoader(), fallbackFeedLoader: self.anyFeedLoader())
        XCTAssertNotNil(feedLoader)
    }
    
    func test_RemoteFeedLoader_FetchDataSuccess_ShouldNot_FallBackTo_LocalFeedLoader() {
        let remoteFeedLoader = self.anyFeedLoader()
        let localFeedLoader = self.anyFeedLoader()
        
        let removeWithLocalFallbackFeedLoader = remoteFeedLoader.fallback(localFeedLoader)
        
        removeWithLocalFallbackFeedLoader.fetchFeed { _ in }
        
        remoteFeedLoader.mockSuccess()
        XCTAssertEqual(remoteFeedLoader.numberOfCallCount(), 1)
        XCTAssertEqual(localFeedLoader.numberOfCallCount(), 0)
    }
}

extension TestFallbackableFeedLoader {
    
    class AnyFeedLoader: FeedLoader, Equatable {
        
        private var requests: [(Result<[FeedItem], Error>) -> Void] = []
        
        static func == (lhs: AnyFeedLoader, rhs: AnyFeedLoader) -> Bool {
            lhs.id == rhs.id
        }
        private let id = UUID()
        
        func fetchFeed(onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
            requests.append(onComplete)
        }
        
        func numberOfCallCount() -> Int {
            return requests.count
        }
        
        func mockSuccess() {
            self.requests[0](.success([]))
        }
    }
    
    func anyFeedLoader() -> AnyFeedLoader {
        AnyFeedLoader()
    }
}
