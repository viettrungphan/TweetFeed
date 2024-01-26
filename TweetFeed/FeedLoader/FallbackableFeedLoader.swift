//
//  FallbackableFeedLoader.swift
//  TweetFeed
//
//  Created by MacOS on 25/01/2024.
//

import Foundation

/*
    FalbackableFeedLoader is Composition Loader class.
    It take advantage of Composition architecture over the inhenritance
    
 - In this implementation, we can easy combine RemoteFeedLoader and LocalFeedLoader to encapsulation the business logic of: "If load network failed then we load data from cache(local)" by:
        Code:
        remoteFeetLoader.fallback(localFeedLoader)
 
 - For example in the future, the requirements changed to load loacal first then remote later to quickly show data to the user, we can easyly swap position to change the logic without change the logic code base:
        Code":
        localFeedLoader.fallback(remoteFeedLoader)
 
 - Or add extra logic for example the reload logic:
 
        Code:
        remoteFeetLoader
                .retry(1)
                .fallback(localFeedLoader)
    
 
 */

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
