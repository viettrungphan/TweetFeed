//
//  FeedLoader.swift
//  TweetFeed
//
//  Created by MacOS on 23/01/2024.
//

import Foundation

protocol FeedLoader {
    func fetchFeed(onComplete: @escaping (Result<[FeedItem], Error>)->Void)
}

