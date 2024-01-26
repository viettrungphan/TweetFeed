//
//  LocalStorageTest.swift
//  TweetFeedTests
//
//  Created by MacOS on 24/01/2024.
//

import Foundation

final class LocalStorageMock: Storage {
    
    var spyNumberOfCacheCallCount = 0
    var spyNumberOfGetCallCount = 0
    
    private var cache: [FeedItem] = []
    
    func cacheFeed(_ feed: [FeedItem]) {
        spyNumberOfCacheCallCount += 1
        self.cache = feed
    }
    
    func getFeed() -> [FeedItem] {
        spyNumberOfGetCallCount += 1
        return cache
    }
}
