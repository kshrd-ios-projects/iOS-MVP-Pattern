//
//  EditViewController.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 26/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit
import Kingfisher

class EditViewController: UIViewController {
    static var post: Article!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    var articlePresenter: ArticlePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPost()
    }
    
    fileprivate func loadPost() {
        if let p = EditViewController.post {
            print(p)
            let string = p.image ?? "http://placehold.jp/375x250.png"
            let url = URL(string: string)
            let resource = ImageResource(downloadURL: url!)
            self.postImage.kf.setImage(with: resource, options: [.transition(.fade(0.2))])
            titleTextField.text = p.title
            descriptionLabel.text = p.description
        }
    }
}
