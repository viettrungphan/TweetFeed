//
//  LocalFeedLoader.swift
//  TweetFeed
//
//  Created by MacOS on 24/01/2024.
//

import Foundation

final class LocalFeedLoader: FeedLoader {
    
    private let storage:Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func fetchFeed(onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
        onComplete(.success(storage.getFeed()))
    }
}
