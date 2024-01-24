//
//  LocalStorageTest.swift
//  TweetFeedTests
//
//  Created by MacOS on 24/01/2024.
//

import Foundation

final class LocalStorageMock: Storage {
    func cacheFeed(_ feed: [FeedItem]) {
    }
    
    func getFeed() -> [FeedItem] {
        return []
    }
}
