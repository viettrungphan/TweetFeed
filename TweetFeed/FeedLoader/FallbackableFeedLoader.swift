//
//  FallbackableFeedLoader.swift
//  TweetFeed
//
//  Created by MacOS on 25/01/2024.
//

import Foundation
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
