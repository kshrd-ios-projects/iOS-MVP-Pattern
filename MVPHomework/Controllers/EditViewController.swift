//
//  EditViewController.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 26/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit
import Alamofire

class EditViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    
    var articlePresenter: ArticlePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
