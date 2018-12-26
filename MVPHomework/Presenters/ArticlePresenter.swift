//
//  ArticlePresenter.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 24/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import Foundation
import UIKit

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
    
    func deleteArticle(id: Int) {
        articleService?.deleteArticle(id: id)
    }
    
    func responseDelete(message: String) {
        self.delegate?.responseDelete(message: message)
    }
    
    func addArticle(article: Article) {
        articleService?.addArticle(article: article)
    }
    
    func responseAdded() {
        self.delegate?.responseAdded()
    }
    
    func uploadImage(image: UIImage) {
        articleService?.uploadImage(image: image)
    }
    
    func responseImage(url: String) {
        self.delegate?.responseImage(url: url)
    }
}
