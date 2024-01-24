//
//  TestNetworking.swift
//  TweetFeedTests
//
//  Created by MacOS on 23/01/2024.
//

import Foundation

final class NetworkTest: FeedLoaderNetworking {
    
    var requests: [(Result<[FeedItem], Error>) -> Void] = []
    
    func request(url: URL, onComplete: @escaping (Result<[FeedItem], Error>) -> Void) {
        requests.append(onComplete)
    }
}
