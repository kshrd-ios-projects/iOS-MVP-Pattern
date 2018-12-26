//
//  Article.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 24/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import Foundation
import SwiftyJSON

class Article {
    var id: Int?
    var title: String?
    var description: String?
    var category: Category?
    var image: String?
    
    init(){}
    
    init(json: JSON) {
        self.id = json["ID"].int
        self.title = json["TITLE"].string
        self.description = json["DESCRIPTION"].string
        self.category = Category.init(json: json["CATEGORY"] )
        self.image = json["IMAGE"].string
    }
    
}
