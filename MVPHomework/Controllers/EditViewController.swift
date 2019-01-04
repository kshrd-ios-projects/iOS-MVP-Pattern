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
        
        articlePresenter = ArticlePresenter()
        articlePresenter?.delegate = self
        loadPost()
    }
    
    fileprivate func loadPost() {
        if let p = EditViewController.post {
            let string = p.image ?? "http://placehold.jp/375x250.png"
            let url = URL(string: string)
            let resource = ImageResource(downloadURL: url!)
            self.postImage.kf.setImage(with: resource, options: [.transition(.fade(0.2))])
            titleTextField.text = p.title
            descriptionLabel.text = p.description
        }
    }
    
    @IBAction func updateArticle(_ sender: Any) {
        let article = Article()
        article.id = EditViewController.post.id
        article.title = titleTextField.text
        article.description = descriptionLabel.text
        article.image = EditViewController.post.image
        print("Update ===> ", article.description)
        self.articlePresenter?.updateArticle(article: article)
    }
    
}

extension EditViewController: ArticlePresenterDelegate {
    func responseArticles(articles: [Article]) {
    }
    
    func responseDelete(message: String) {
    }
    
    func responseAdded() {
    }
    
    func responseImage(url: String) {
    }
    
    func responseUpdated() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
