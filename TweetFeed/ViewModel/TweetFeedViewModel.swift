//
//  TweetFeedViewModel.swift
//  TweetFeed
//
//  Created by MacOS on 25/01/2024.
//

import Foundation

final class TweetFeedViewModel {
    
    private let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    func loadFeed(onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
        self.feedLoader.fetchFeed(onComplete: onComplete)
    }
}
