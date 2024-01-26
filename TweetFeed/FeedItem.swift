//
//  FeedItem.swift
//  TweetFeed
//
//  Created by MacOS on 23/01/2024.
//

import Foundation

struct FeedItem: Decodable {
    let id: UUID
    let title: String
    let subTitle: String
    let image: String
}
