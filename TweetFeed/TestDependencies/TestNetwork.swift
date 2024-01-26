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
        [FeedItem(id: UUID()), FeedItem(id: UUID())]
    }
}
