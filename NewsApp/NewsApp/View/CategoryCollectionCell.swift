//
//  CategoryCollectionCell.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import UIKit
import Model

protocol CategoryCellProtocol {
    var title: String {get}
}

struct CategoryCellModel: CategoryCellProtocol {
    var title: String {
        return self.category.key
    }
    
    private let category: Model.Category
    
    init(category: Model.Category) {
        self.category = category
    }
}

class CategoryCollectionCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionCell"
    
    @IBOutlet var categoryLabel: UILabel!
    
    var category: CategoryCellModel? {
        didSet {
            self.configure(category)
        }
    }
    
    func configure(_ category: CategoryCellModel?) {
        guard let model = category else { return }
        categoryLabel.text = model.title
    }
}
