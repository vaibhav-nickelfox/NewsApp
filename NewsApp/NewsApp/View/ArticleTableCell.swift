//
//  ArticleTableCell.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import UIKit
import Model

struct ArticleCellModel {
    var title: String { return article.headLine }
    var description: String { return article.desc }
    var source: String { return article.source }
    //var date: String { return article.date }
    var webUrl: String { return article.webUrl }
    var imageUrl: String { return article.imageUrl }
    
    private let article: Article
    
    init (article: Article) {
        self.article = article
    }
}


class ArticleTableCell: UITableViewCell {

    static let identifier = "ArticleTableCell"
    
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var headlineLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.thumbnailView.image = nil
    }
    
    var article: ArticleCellModel? {
        didSet {
            self.configure(article)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ model: ArticleCellModel?) {
        guard let article = model else { return }
        self.headlineLabel.text = article.title
        self.descriptionLabel.text = article.description
        self.sourceLabel.text = article.source
        self.thumbnailView.downloadImage(from: article.imageUrl)
    }

}
