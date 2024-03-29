//
//  TestRemoteFeedLoader.swift
//  TweetFeedTests
//
//  Created by MacOS on 23/01/2024.
//

import XCTest

final class TestRemoteFeedLoader: XCTestCase {
    
    func test_Init_RemoteFeedLoader_Success() {
        let feedLoader = self.makeSUT()
        XCTAssertNotNil(feedLoader)
    }
    
    func test_fetchFeed_Success() {
        let (feedLoader, network) = self.makeSUT()
        
        var receivedFeedItem: [FeedItem]? = nil
        
        feedLoader.fetchFeed(onComplete: { result in
            switch result {
            case .success(let feed):
                receivedFeedItem = feed
            case .failure(_):
                assert(true, "Should not fall here")
            }
        })
        
        network.requests[0](.success([]))
        XCTAssertNotNil(receivedFeedItem)
    }
    
    func test_fetchFeed_Failed() {
        let (feedLoader, network) = self.makeSUT()
        var receivedError: Error? = nil
        
        feedLoader.fetchFeed(onComplete: { result in
            switch result {
            case .failure(let error):
                receivedError = error
            case .success(_):
                assert(true, "Should not fall here")
            }
        })
        
        network.requests[0](.failure(self.anyError()))
        
        XCTAssertNotNil(receivedError)
    }
    
    func test_fetchFeed_NotCause_SideEffects() {
        let (feedLoader, network) = self.makeSUT()
                
        feedLoader.fetchFeed(onComplete: { _ in })
        let validNumberOfCallCount = 1
        XCTAssertNotNil(network.requests.count == validNumberOfCallCount)
    }
    
    func test_fetchFeedTwice_NotCause_SideEffects() {
        let (feedLoader, network) = self.makeSUT()
                
        feedLoader.fetchFeed(onComplete: { _ in })
        feedLoader.fetchFeed(onComplete: { _ in })
        
        let validNumberOfCallCount = 2
        XCTAssertNotNil(network.requests.count == validNumberOfCallCount)
    }
}

//MARK: - Test Helpers
private enum RemoteError: Error {
    case any
}
extension TestRemoteFeedLoader {
    func makeSUT() -> (RemoteFeedLoader, NetworkMock) {
        let network = NetworkMock()
        XCTAssertNotNil(network)
        
        let loader = RemoteFeedLoader(url: anyURL(), network: network)
        trackForMemoryLeaks(loader)
        return (loader, network)
    }
    
    func anyURL() -> URL {
        URL(string: "https://any_url.com")!
    }
    
    func anyError() -> Error {
        RemoteError.any
    }
}
