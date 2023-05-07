//
//  ViewController.swift
//  GoodNews
//
//  Created by Luan.Lima on 04/05/23.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    var service: WebService?

    var articlesNews: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        service?.getArticles { articles in
            self.articlesNews = articles.articles
            self.tableView.reloadData()
        } failureHandler: { error in
            print(error.localizedDescription)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return articlesNews.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let articles = articlesNews[indexPath.row]
        cell.article(articles)
        return cell
    }
}

