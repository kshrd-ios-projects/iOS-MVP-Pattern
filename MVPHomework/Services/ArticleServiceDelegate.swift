//
//  ArticleServiceDelegate.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 24/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import Foundation

protocol ArticleServiceDelegate {
    func responseArticles(articles: [Article])
    func responseDelete(message: String)
    func responseAdded()
    func responseImage(url: String)
    func responseUpdated()
}
