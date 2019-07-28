//
//  ArticleTableViewController.swift
//  Article-with-MVVM
//
//  Created by Soeng Saravit on 7/15/19.
//  Copyright © 2019 KSHRD. All rights reserved.
//

import UIKit
import SVProgressHUD

class ArticleTableViewController: UITableViewController {
    
    var page = 1
    var limit = 15
    var articleListViewModel:ArticleListViewModel?
    var articleViewModels:[ArticleViewModel]?
    var paginationViewModel:PaginationViewModel?
    
    var indicatorView:UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        SVProgressHUD.setBackgroundColor(.black)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show()
        self.indicatorView = UIActivityIndicatorView(style: .gray)
        
        self.articleListViewModel = ArticleListViewModel()
        self.articleListViewModel?.fetchArticles(page: page, limit: limit, completion: { (articleViewModels, paginationViewModel) in
            self.articleViewModels = articleViewModels
            self.paginationViewModel = paginationViewModel
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let articleViewModels = self.articleViewModels {
            return articleViewModels.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        let articleViewModel = self.articleViewModels![indexPath.row]
        
        cell.bindData(articleViewModel: articleViewModel)

        return cell
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (tableView.contentOffset.y + tableView.frame.height) >= tableView.contentSize.height {
            if (self.articleViewModels?.count)! < (self.paginationViewModel?.totalCount)! {
                self.tableView.tableFooterView = indicatorView
                self.tableView.tableFooterView?.center = (indicatorView?.center)!
                self.indicatorView?.startAnimating()
                page += 1
                self.articleListViewModel?.fetchArticles(page: page, limit: limit, completion: { (articleViewModels, paginationViewModel) in
                    self.articleViewModels = self.articleViewModels! + articleViewModels
                    DispatchQueue.main.async {
                        self.indicatorView?.stopAnimating()
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }
}
