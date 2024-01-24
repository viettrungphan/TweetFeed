//
//  TestLocalFeedLoader.swift
//  TweetFeedTests
//
//  Created by MacOS on 24/01/2024.
//

import XCTest

final class LocalFeedLoader: FeedLoader {
    var localData:[FeedItem] = []
    
    func fetchFeed(onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
        onComplete(.success(localData))
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
    
    func test_Storage_Has_Cache_ReturnCache() {
        let feedLoader = self.makeSUT()
        
        let exp = self.expectation(description: "Expect Local Storage had cache data, return cache data")
        
        let mockLocalData = self.mockLocalData()
        feedLoader.localData = mockLocalData
        
        feedLoader.fetchFeed { result in
            switch result {
            case .success(let feed):
                XCTAssertEqual(feed, mockLocalData)
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
        trackForMemoryLeaks(feedLoader)
        return feedLoader
    }
    
    func anyFeedItem() -> FeedItem {
        FeedItem(id: UUID())
    }
    
    func mockLocalData() -> [FeedItem] {
        [anyFeedItem()]
    }
    
}

extension FeedItem: Equatable {
    static func == (lhs: FeedItem, rhs: FeedItem) -> Bool {
        lhs.id == rhs.id
    }
}
