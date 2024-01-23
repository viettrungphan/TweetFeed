//
//  RemoteFeedLoader.swift
//  TweetFeed
//
//  Created by MacOS on 23/01/2024.
//

import Foundation

final class RemoteFeedLoader: FeedLoader {
    enum RemoteError: Error {
        case any
    }
    var isSuccess = false

    func fetchFeed(onComplete: (Result<[FeedItem], Error>)->Void) {
        if isSuccess {
            onComplete(.success([]))
        } else {
            onComplete(.failure(self.anyError()))
        }
    }
    
    func anyError() -> Error {
        RemoteError.any
    }
}
