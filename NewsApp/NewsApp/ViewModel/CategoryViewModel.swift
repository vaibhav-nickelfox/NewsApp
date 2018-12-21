//
//  CategoryViewModel.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import FoxAPIKit
import ReactiveSwift
import Model

class CategoryViewModel {
    var loading = MutableProperty<Bool>(false)
    var cellModels = MutableProperty<[CategoryCellModel]>([])
    var disposable = CompositeDisposable([])
    
    deinit {
        disposable.dispose()
    }
    
    init() {
        self.disposable += self.loading <~ self.fetchSourceAction.isExecuting
        self.disposable += self.fetchSourceAction.values.observeValues({ (sources) in
            self.sources = sources
        })
        self.disposable += self.fetchSourceAction.errors.observeValues({ (error) in
            print("Error: \(error.code) \(error.message)")
        })
    }
    
    fileprivate(set) public var sources: [Source] = [] {
        didSet {
            self.cellModels.value = Model.Category.groupCategories(sources: sources).map {
                CategoryCellModel.init(category: $0)
            }
        }
    }
    
    fileprivate let fetchSourceAction = Action { () -> SignalProducer<[Source], NewsError> in
        return Source.fetchSources()
    }
}

extension CategoryViewModel {
    func fetchSources() {
        self.disposable += self.fetchSourceAction.apply().start()
    }
}
