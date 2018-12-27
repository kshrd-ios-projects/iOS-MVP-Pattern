//
//  ViewController.swift
//  MVPHomework
//
//  Created by Sreng Khorn on 24/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, ArticlePresenterDelegate {
    @IBOutlet weak var tableView: UITableView!
    let CELL_ID = "cellResuableId"
    
    var articlePresenter: ArticlePresenter?
    var posts = [Article]()
    let refreshControl = UIRefreshControl()
    var pagination = 1
    
    func refresher() {
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...")
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.addSubview(refreshControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher()
        
        tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: CELL_ID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.posts = []
        pagination = 1
        articlePresenter = ArticlePresenter()
        articlePresenter?.delegate = self
        fetchData()
    }
    
    func responseArticles(articles: [Article]) {
        self.posts += articles
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.refreshControl.endRefreshing()
        
    }
    
    @objc func fetchData() {
        self.articlePresenter?.getArticles(page: pagination, limit: 2)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastPost = posts.count - 1
        if indexPath.row == lastPost {
            self.pagination += 1
            fetchData()
        }
    }
    @IBAction func addPost(_ sender: Any) {
        performSegue(withIdentifier: "postFormSegue", sender: self)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! TableViewCell
        let post = posts[indexPath.row]
        let imgUrl = post.image ?? ""
        if let url = URL(string: imgUrl) {
            cell.imgPost.kf.indicatorType = .activity
            cell.imgPost?.kf.setImage(
                                    with: url,
                                    placeholder: UIImage(named: "default-image"),
                                    options: [.transition(.fade(0.2))])
        }
        cell.titleLabel.text = post.title!
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            print(self.posts[indexPath.row])
            EditViewController.post = self.posts[indexPath.row]
            self.performSegue(withIdentifier: "editFormSegue", sender: self)
            
        })
        editAction.image = UIImage(named: "icons8-edit-file-filled-32")
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let post = self.posts[indexPath.row]
            self.articlePresenter?.deleteArticle(id: post.id!)
            self.posts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        deleteAction.image = UIImage(named: "icons8-trash-filled-32")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showArticleSegue", sender: self)
        ShowViewController.post = posts[indexPath.row]
    }
    
    func responseDelete(message: String) {
        print(message)
        self.tableView.reloadData()
    }
    
    func responseAdded() {}
    func responseImage(url: String) {
    }
}
