//
//  TestNetwork.swift
//  TweetFeed
//
//  Created by MacOS on 26/01/2024.
//

import Foundation

final class TestNetwork: FeedLoaderNetworking {
    typealias DecodeData = [FeedItem]
    
    func request(url: URL, onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
        onComplete(.success(self.dummyFeedItem()))
    }
    
    func dummyFeedItem() -> [FeedItem] {
        [
            FeedItem(id: UUID(), title: "Test title", subTitle: "The very quick brown fox, jump over the lazy dog", image: "star"),
            FeedItem(id: UUID(), title: "Can I pass the final interview?", subTitle: "Let's see how good you are first 😆", image: "sun.max")
        ]
    }
}

