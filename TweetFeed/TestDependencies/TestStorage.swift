//
//  TestStorage.swift
//  TweetFeed
//
//  Created by MacOS on 26/01/2024.
//

import Foundation
final class TestStorage: Storage {
    private var cache:[FeedItem] = []
    
    func cacheFeed(_ feed: [FeedItem]) {
        self.cache = feed
    }
    
    func getFeed() -> [FeedItem] {
        cache
    }
}
