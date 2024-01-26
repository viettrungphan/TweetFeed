//
//  TweetFeedTableViewCell.swift
//  TweetFeed
//
//  Created by MacOS on 26/01/2024.
//

import UIKit

final class TweetFeedTableViewCell: UITableViewCell {
    static let reuseIdentifyer = "TweetFeedTableViewCell"
    
    func configCell(feed: FeedItem) {
        var content = self.defaultContentConfiguration()
        content.image = UIImage(systemName: "star")
        content.text = "John Doe"
        content.secondaryText = "Hello word"
        self.contentConfiguration = content
    }

}
