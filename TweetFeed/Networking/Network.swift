//
//  NetworkType.swift
//  TweetFeed
//
//  Created by MacOS on 23/01/2024.
//

import Foundation

protocol Network {
    associatedtype DecodeData
    func request(url: URL, onComplete: @escaping (Result<DecodeData, Error>)->Void)
}
