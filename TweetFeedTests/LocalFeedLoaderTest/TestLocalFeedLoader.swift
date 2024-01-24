//
//  TestLocalFeedLoader.swift
//  TweetFeedTests
//
//  Created by MacOS on 24/01/2024.
//

import XCTest

final class LocalFeedLoader: FeedLoader {
    
    private let storage:Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func fetchFeed(onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
        onComplete(.success(storage.getFeed()))
    }
}

final class TestLocalFeedLoader: XCTestCase {
    func test_Init_Loader_Success() {
        let (feedLoader, storage) = self.makeSUT()
        
        XCTAssertNotNil(feedLoader)
        XCTAssertNotNil(storage)
    }
    
    func test_Init_NewFeedLoader_ShouldReturn_EmptyFeed() {
        let (feedLoader, _) = self.makeSUT()
        
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
        let (feedLoader, storage) = self.makeSUT()
        
        let exp = self.expectation(description: "Expect Local Storage had cache data, return cache data")
        
        let mockLocalData = self.mockLocalData()
        storage.cacheFeed(mockLocalData)
        
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
    func makeSUT() -> (LocalFeedLoader, Storage) {
        let storage = LocalStorageMock()
        let feedLoader = LocalFeedLoader(storage: storage)
        trackForMemoryLeaks(feedLoader)
        return (feedLoader, storage)
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
