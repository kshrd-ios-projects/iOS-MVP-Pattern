//
//  ArticlePresenter.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 24/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import Foundation

class ArticlePresenter: ArticleServiceDelegate {
    
    var delegate: ArticlePresenterDelegate?
    var articleService: ArticleService?
    
    init() {
        articleService = ArticleService()
        articleService?.delegate = self
    }
    
    func getArticles(page: Int, limit: Int) {
        articleService?.getArticles(page: page, limit: limit)
    }
    
    func responseArticles(articles: [Article]) {
        self.delegate?.responseArticles(articles: articles)
    }
}
