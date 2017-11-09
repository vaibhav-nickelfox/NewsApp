//
//  Category.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import ReactiveSwift

public class  Category {
    public var key: String?
    public var sources: [Source]
    
    public init(key: String, sources: [Source]) {
        self.key = key
        self.sources = sources
    }
    
    public static func groupCategories(sources: [Source]) -> [Category] {
        var categories: [Category] = []
        for source in sources {
            if let index = indexOfCategory(key: source.category, in: categories) {
                let foundCategory = categories[index]
                foundCategory.sources.append(source)
            } else {
                let newCategory = Category(key: source.category, sources: [source])
                categories.append(newCategory)
            }
        }
        return categories
    }
}

fileprivate func indexOfCategory(key:String, in categories: [Category]) -> Int? {
    var index = 0
    for category in categories {
        if key == category.key {
            return index
        }
        index += 1
    }
    return nil
}
