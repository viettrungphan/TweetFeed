//
//  TestNetworking.swift
//  TweetFeedTests
//
//  Created by MacOS on 23/01/2024.
//

final class NetworkTest: Network {
    typealias DecodeData = FeedItem
    
    var requests: [(Result<FeedItem, Error>) -> Void] = []
    
    func request(url: String, onComplete: @escaping (Result<FeedItem, Error>) -> Void) {
        requests.append(onComplete)
    }
}
