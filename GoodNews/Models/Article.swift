//
//  Articles.swift
//  GoodNews
//
//  Created by Luan.Lima on 04/05/23.
//

import Foundation

// MARK: - ArticlesList
struct ArticlesList: Codable {
    let articles: [Article]
    
    init(articles: [Article]) {
        self.articles = articles
    }
}

// MARK: - Article
struct Article: Codable {
    let title: String?
    let description: String?
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

