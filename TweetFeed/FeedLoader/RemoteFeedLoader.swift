//
//  RemoteFeedLoader.swift
//  TweetFeed
//
//  Created by MacOS on 23/01/2024.
//

import Foundation

//Set type contraint
protocol FeedLoaderNetworking: Network where DecodeData == [FeedItem] {
}

final class RemoteFeedLoader: FeedLoader {
        
    private let network: any FeedLoaderNetworking
    private let url: URL
    
    init(url: URL, network: any FeedLoaderNetworking) {
        self.network = network
        self.url = url
    }
    
    func fetchFeed(onComplete: @escaping (Result<[FeedItem], Error>)->Void) {
        network.request(url: url) { result in
            onComplete(result)
        }
    }
}
