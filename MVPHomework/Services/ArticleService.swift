//
//  ArticleService.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 24/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ArticleService {
    let ARTICLE_BASE_URL = "http://api-ams.me/v1/api/articles"
    let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="
    ]
    var delegate: ArticleServiceDelegate?
    
    func getArticles(page: Int, limit: Int) {
        
        let urlRequest = "\(ARTICLE_BASE_URL)?page=\(page)&limit=\(limit)"
        Alamofire.request(urlRequest, method: .get, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            let result = response.result
            if result.isSuccess {
                
                let json = try?  JSON(data: result.value!)
                guard let articleJsonArray = json!["DATA"].array else {
                    print("Error")
                    return
                }
                if articleJsonArray.count == 0 {
                    return
                }
                var articles = [Article]()
                for articleJson in articleJsonArray {
                    articles.append(Article.init(json: articleJson))
                }
                
                self.delegate?.responseArticles(articles: articles)
            }
        }
    }
    
    func deleteArticle(id: Int) {
        let url = "\(ARTICLE_BASE_URL)/\(id)"
        Alamofire.request(url, method: .delete, headers: headers).responseJSON { (response) in
            guard response.result.error == nil else {
                print("error calling DELETE")
                if let error = response.result.error {
                    print("Error: \(error)")
                }
                return
            }
            
            if response.result.isSuccess {
                self.delegate?.responseDelete(message: "Delete Successfully")
            }
        }
    }
    
    func addArticle(article: Article) {
        let url = ARTICLE_BASE_URL
        let parameters: [String: Any] = [
            "TITLE": article.title!,
            "DESCRIPTION": article.description!,
            "IMAGE": article.image!
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                self.delegate?.responseAdded()
            }
            
            if response.result.isFailure {
                print("Error =>>", response.result.error!)
            }
        }
    }
    
    func uploadImage(image: UIImage) {
        let url = "http://api-ams.me/v1/api/uploadfile/single"
        Alamofire.upload(multipartFormData: { (data) in
            data.append((image.jpegData(compressionQuality: 0.2))!, withName: "FILE", fileName: ".jpg", mimeType: "image/jpeg")
        }, to: url, method: .post, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseData(completionHandler: { (response) in
                    let image = try? JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: Any]
                    guard let imageUrlString = image!["DATA"] else { return }
                    let imageUrl = imageUrlString as! String
                    self.delegate?.responseImage(url: imageUrl)
                })
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    func updateArticle(id: Int) {
        let url = "\(ARTICLE_BASE_URL)/\(id)"
    }
}

