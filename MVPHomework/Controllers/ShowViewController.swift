//
//  ShowViewController.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 26/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ShowViewController: UIViewController {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    static var post: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPost()
    }
    
    fileprivate func loadPost() {
        if let p = ShowViewController.post {
            let string = p.image ?? "http://placehold.jp/375x250.png"
            let url = URL(string: string)
            let resource = ImageResource(downloadURL: url!)
            self.postImage.kf.setImage(with: resource, options: [.transition(.fade(0.2))])
            titleLabel.text = p.title
            descriptionLabel.text = p.description
        }
    }
    
    

}
