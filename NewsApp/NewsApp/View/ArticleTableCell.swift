//
//  ArticleTableCell.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import UIKit

class ArticleTableCell: UITableViewCell {

    static let identifier = "ArticleTableCell"
    
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var headlineLable: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
