//
//  Article.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import FoxAPIKit
import ReactiveSwift
import JSONParsing

final public class Article {
    public var headLine: String
    public var desc: String
    public var date: String
    public var webUrl: String
    public var imageUrl: String
    public var source: String = ""
    
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
            NewsAPIClient.shared.request(NewsAPIRouter.articles(source: source.id)) {
                (result: APIResult<ListResponse<Article>>) in
                switch result {
                case .success(let response):
                    var articles: [Article] = []
                    for article in response.list {
                        article.source = source.name
                        articles.append(article)
                    }
                    observer.send(value: articles)
                    observer.sendCompleted()
                case .failure(let error):
                    let error = NewsError(code: error.code, title: "Error", message: error.message)
                    observer.send(error: error)
                    //observer.send(error: NewsError(code: error.code, title: error.title, message: error.message))
                }
            }
        })
    }
}
