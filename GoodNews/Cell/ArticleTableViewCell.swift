//
//  ArticleTableViewCell.swift
//  GoodNews
//
//  Created by Luan.Lima on 05/05/23.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
   
    func article(_ article: Article?) {
        titleLabel.text = article?.title
        descriptionLabel.text = article?.description
    }  
}
