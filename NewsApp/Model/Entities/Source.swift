//
//  Source.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import FoxAPIKit
import ReactiveSwift
import JSONParsing

final public class Source {
    public var id: String
    public var name: String
    public var category: String
    
    init(id: String, name: String, category: String) {
        self.id = id
        self.name = name
        self.category = category
    }
}

extension Source: JSONParseable {
    public static func parse(_ json: JSON) throws -> Source {
        return try Source(id: json["id"]^, name: json["name"]^, category: json["category"]^)
    }
}

extension Source {
    public static func fetchSources() -> SignalProducer<[Source], NewsError> {
        return SignalProducer.init({ (observer, lifetime) in
            NewsAPIClient.shared.request(NewsAPIRouter.sources) {(result: APIResult<ListResponse<Source>>) in
                switch result {
                case .success(let response):
                    observer.send(value: response.list)
                    observer.sendCompleted()
                case .failure(let error):
                    let error = NewsError(code: error.code, title: "Error", message: error.message)
                    observer.send(error: error)
//                    observer.send(error: NewsError(code: error.code, title: error.title, message: error.message))
                }
            }
        })
    }
}
