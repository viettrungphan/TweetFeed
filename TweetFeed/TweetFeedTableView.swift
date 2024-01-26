//
//  TweetFeedCollectionView.swift
//  TweetFeed
//
//  Created by MacOS on 26/01/2024.
//

import UIKit

final class TweetFeedTableView: UITableView {
    
    private var feed: [FeedItem] = []
    
    func reloadTableView(feed: [FeedItem]) {
        self.feed = feed
        self.reloadData()
    }
    
    func setupTableView() {
        self.dataSource = self
        self.delegate = self
        self.register(TweetFeedTableViewCell.self, forCellReuseIdentifier: TweetFeedTableViewCell.reuseIdentifyer)
    }
    
    func showEmptyScreenIfNeeded() {
        //Show Empty background
    }
}

extension TweetFeedTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetFeedTableViewCell.reuseIdentifyer, for: indexPath) as! TweetFeedTableViewCell
        cell.configCell(feed:feed[indexPath.row])
        return cell
    }
}

extension TweetFeedTableView: UITableViewDelegate {
    
}
