//
//  NewsAPIRouter.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import APIClient

public enum NewsAPIRouter: Router {
    case articles(source: String)
    case sources
}

extension NewsAPIRouter {
    public var method: HTTPMethod {
        let method: HTTPMethod
        switch self {
        case .sources, .articles:
            method = .get
        }
        return method
    }
    
    public var path: String {
        switch self {
        case .sources: return "/sources"
        case .articles: return "/articles"
        }
    }
    
    public var params: [String: Any] {
        var parameters: [String: Any]
        switch self {
        case .sources:
            parameters = ["language": "en"]
        case .articles(let source):
            parameters = ["apiKey": ModleConfig.apikey,
                          "source": source,
                          "sortBy": "top"]
        }
        return parameters
    }
    
    public var baseUrl: URL {
        return URL(string: ModleConfig.baseUrl)!
    }
    
    public var headers: [String: String] {
        return ["Accept": "application/json"]
    }
    
    public var encoding: URLEncoding? {
        return nil
    }
    
    public var timeoutInterval: TimeInterval?  {
        return nil
    }
    
    public var keypathToMap: String? {
        let keyPath: String
        switch self {
        case .sources: keyPath = "sources"
        case .articles: keyPath = "articles"
        }
        return keyPath
    }
}
