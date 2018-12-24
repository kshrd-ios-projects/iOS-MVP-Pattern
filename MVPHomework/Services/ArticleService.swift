//
//  ArticleService.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 24/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import Foundation
import SwiftyJSON

class ArticleService {
    let ARTICLE_URL = "http://api-ams.me/v1/api/articles"
    var delegate: ArticleServiceDelegate?
    
    func getArticles(page: Int, limit: Int) {
        
        var request = URLRequest(url: URL(string: "\(ARTICLE_URL)?page=\(page)&limit=\(limit)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=" , forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                
                let json = try?  JSON(data: data!)
                let articleJsonArray = json!["DATA"].array
                
                var articles = [Article]()
                for articleJson in articleJsonArray! {
                    articles.append(Article.init(json: articleJson))
                }
                self.delegate?.responseArticles(articles: articles)
            }
        }.resume()
        
    }
}
