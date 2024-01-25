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
    
    func test_RemoteFeedLoader_FetchDataFaile_FallBackTo_LocalFeedLoader() {
        let remoteFeedLoader = self.anyFeedLoader()
        let localFeedLoader = self.anyFeedLoader()
        
        let removeWithLocalFallbackFeedLoader = remoteFeedLoader.fallback(localFeedLoader)
        
        removeWithLocalFallbackFeedLoader.fetchFeed { _ in }
        
        remoteFeedLoader.mockFailed()
        localFeedLoader.mockSuccess()
        XCTAssertEqual(remoteFeedLoader.numberOfCallCount(), 1)
        XCTAssertEqual(localFeedLoader.numberOfCallCount(), 1)
    }
    
    func test_RemoteFeedLoader_FetchDataSuccess_ReceiveSuccess_Data() {
        let remoteFeedLoader = self.anyFeedLoader()
        let localFeedLoader = self.anyFeedLoader()
        
        let removeWithLocalFallbackFeedLoader = remoteFeedLoader.fallback(localFeedLoader)
        
        var callbackData:[FeedItem]?
        
        removeWithLocalFallbackFeedLoader.fetchFeed { result in
            switch result {
            case .success(let feed):
                callbackData = feed
            case .failure(_):
                assert(true, "Should not fall here")
            }
        }
        
        remoteFeedLoader.mockSuccess()
        XCTAssertNotNil(callbackData)
    }
    
    func test_RemoteFeedLoader_FetchDataFail_LocalFeedLoader_FetchDataSuccess_Receive_Success_Data() {
        let remoteFeedLoader = self.anyFeedLoader()
        let localFeedLoader = self.anyFeedLoader()
        
        let removeWithLocalFallbackFeedLoader = remoteFeedLoader.fallback(localFeedLoader)
        
        var callbackData:[FeedItem]?
        
        removeWithLocalFallbackFeedLoader.fetchFeed { result in
            switch result {
            case .success(let feed):
                callbackData = feed
            case .failure(_):
                assert(true, "Should not fall here")
            }
        }
        remoteFeedLoader.mockFailed()
        localFeedLoader.mockSuccess()
        XCTAssertNotNil(callbackData)
    }
    
    func test_RemoteFeedLoader_FetchDataFail_LocalFeedLoader_FetchDataFail_Receive_Error() {
        let remoteFeedLoader = self.anyFeedLoader()
        let localFeedLoader = self.anyFeedLoader()
        
        let removeWithLocalFallbackFeedLoader = remoteFeedLoader.fallback(localFeedLoader)
        
        var callbackError:Error?
        
        removeWithLocalFallbackFeedLoader.fetchFeed { result in
            switch result {
            case .success(_):
                assert(true, "Should not fall here")
            case .failure(let error):
                callbackError = error
            }
        }
        remoteFeedLoader.mockFailed()
        localFeedLoader.mockFailed()
        XCTAssertNotNil(callbackError)
    }

}

extension TestFallbackableFeedLoader {
    
    class AnyFeedLoader: FeedLoader, Equatable {
        enum AnyError: Error {
            case any
        }
        
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
        
        func mockFailed() {
            self.requests[0](.failure(anyError()))
        }
        func anyError() -> Error {
            AnyError.any
        }
    }
    
    func anyFeedLoader() -> AnyFeedLoader {
        AnyFeedLoader()
    }
    
    
}
