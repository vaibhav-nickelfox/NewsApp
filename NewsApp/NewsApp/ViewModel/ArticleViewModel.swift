//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import Model
import FoxAPIKit
import ReactiveSwift

class ArticleViewModel {
    var loading = MutableProperty<Bool>(false)
    var cellModles = MutableProperty<[ArticleCellModel]>([])
    var disposable = CompositeDisposable([])
    
    deinit {
        disposable.dispose()
    }
    
    init() {
        self.disposable += self.loading <~ self.fetchArticleAction.isExecuting
        self.disposable += self.fetchArticleAction.values.observeValues({ (articles) in
            self.articles = articles
        })
        self.disposable += self.fetchArticleAction.errors.observeValues({ (error) in
            print("Error: \(error.code) \(error.message)")
        })
    }
    
    fileprivate(set) public var articles: [Article] = [] {
        didSet {
            self.cellModles.value = self.articles.map { ArticleCellModel(article: $0) }
        }
    }
    
    fileprivate let fetchArticleAction = Action { (source: Source) -> SignalProducer<[Article], NewsError> in
        return Article.fetchArticles(from: source)
    }
}

extension ArticleViewModel {
    func fetchArticles(from source: Source) {
        self.disposable += self.fetchArticleAction.apply(source).start()
    }
}
