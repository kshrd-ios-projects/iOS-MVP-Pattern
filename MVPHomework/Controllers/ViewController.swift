//
//  ViewController.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 24/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ArticlePresenterDelegate {
    
    var articlePresenter: ArticlePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        articlePresenter = ArticlePresenter()
        articlePresenter?.delegate = self
        
        articlePresenter?.getArticles(page: 1, limit: 3)
    }
    
    func responseArticles(articles: [Article]) {
        for article in articles {
            print(article.title!)
        }
    }


}

