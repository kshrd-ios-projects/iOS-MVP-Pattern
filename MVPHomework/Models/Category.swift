//
//  Category.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 24/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category {
    var id: Int?
    var name: String?
    
    init(json: JSON) {
        self.id = json["ID"].int
        self.name = json["NAME"].string
    }
}
