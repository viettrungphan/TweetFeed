//
//  Storage.swift
//  TweetFeed
//
//  Created by MacOS on 24/01/2024.
//

import Foundation
protocol Storage {
    func cacheFeed(_ feed: [FeedItem])
    func getFeed() -> [FeedItem]
}
