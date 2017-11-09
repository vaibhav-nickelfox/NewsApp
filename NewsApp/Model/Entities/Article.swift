//
//  Article.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import APIClient
import ReactiveSwift

final public class Article {
    public var headLine: String
    public var desc: String
    public var date: String
    public var webUrl: String
    public var imageUrl: String
    
    public init(headLine: String, desc: String, date: String, webUrl: String, imageUrl: String) {
        self.headLine = headLine
        self.desc = desc
        self.date = date
        self.webUrl = webUrl
        self.imageUrl = imageUrl
    }
}

extension Article: JSONParseable {
    public static func parse(_ json: JSON) throws -> Article {
        return try Article (
            headLine: json["title"]^,
            desc: json["description"]^,
            date: json["publishedAt"]^,
            webUrl: json["url"]^,
            imageUrl: json["urlToImage"]^)
    }
}

extension Article {
    public static func fetchArticles(from source: Source) -> SignalProducer<[Article], NewsError> {
        return SignalProducer.init ({ (observer, lifetime) in
            NewsAPIClient.shared.request(router: NewsAPIRouter.articles(source: source.id)) {
                (result: APIResult<ListResponse<Article>>) in
                switch result {
                case .success(let response):
                    observer.send(value: response.list)
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: NewsError(code: error.code, title: error.title, message: error.message))
                }
            }
        })
    }
}
