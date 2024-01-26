//
//  ViewController.swift
//  TweetFeed
//
//  Created by MacOS on 23/01/2024.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - UIs
    @IBOutlet weak var tableView: TweetFeedTableView!
    
    //Just a dummy viewmodel for showcase only
    //In the real project we should create and inject via Dependency root.
    let viewModel: TweetFeedViewModel = {
        let feedLoader: FeedLoader = FallbackableFeedLoader(primaryFeedLoader: RemoteFeedLoader(url: URL(string: "https://a-url.com")!, network: TestNetwork()), fallbackFeedLoader: LocalFeedLoader(storage: TestStorage()))
        let viewModel = TweetFeedViewModel(feedLoader: feedLoader)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bindData()
    }
    
    private func setupUI() {
        self.tableView.setupTableView()
    }
    
    private func bindData() {
        viewModel.loadFeed {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let feed):
                self.tableView.reloadTableView(feed: feed)
            case .failure(_):
                self.tableView.showEmptyScreenIfNeeded()
            }
        }
    }
}

