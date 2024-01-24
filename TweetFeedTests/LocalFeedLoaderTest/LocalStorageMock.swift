//
//  LocalStorageTest.swift
//  TweetFeedTests
//
//  Created by MacOS on 24/01/2024.
//

import Foundation

final class LocalStorageMock: Storage {
    private var cache: [FeedItem] = []
    func cacheFeed(_ feed: [FeedItem]) {
        self.cache = feed
    }
    
    func getFeed() -> [FeedItem] {
        return cache
    }
}
