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
        content.image = UIImage(systemName: feed.image)
        content.text = feed.title
        content.secondaryText = feed.subTitle
        self.contentConfiguration = content
    }

}
