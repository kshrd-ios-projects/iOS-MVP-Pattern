//
//  FormViewController.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 26/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var articlePresenter: ArticlePresenter?
    var imagePicker = UIImagePickerController()
    var imageUrl = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlePresenter = ArticlePresenter()
        articlePresenter?.delegate = self
        imagePicker.delegate = self
        
        postImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseImage)))
        postImageView.isUserInteractionEnabled = true
    }
    
    @IBAction func savePost(_ sender: Any) {
        let article = Article()
        article.title = titleTextField.text
        article.description = descriptionTextView.text
        article.image = imageUrl
        articlePresenter?.addArticle(article: article)
    }
    
}

extension AddViewController: ArticlePresenterDelegate {
    func responseArticles(articles: [Article]) {
    }
    
    func responseDelete(message: String) {
    }
    
    func responseAdded() {
        print("Added successfully...")
        self.navigationController?.popViewController(animated: true)
    }
    
    func responseImage(url: String) {
        self.imageUrl = url
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func chooseImage(){
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            postImageView.contentMode = .scaleToFill
            postImageView.image = pickedImage
            articlePresenter?.uploadImage(image: postImageView.image!)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
