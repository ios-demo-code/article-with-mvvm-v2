//
//  ArticleListViewModel.swift
//  Article-with-MVVM
//
//  Created by Soeng Saravit on 7/12/19.
//  Copyright © 2019 KSHRD. All rights reserved.
//

import Foundation

class ArticleListViewModel {
    
    // Mark: - Request Article Service to fetch data from API
    func fetchArticles(page:Int, limit:Int, completion: @escaping (_ articleViewModels:[ArticleViewModel], _ paginationViewModel:PaginationViewModel)->Void) {
        
        ArticleService.shared.fetchArticles(page: page, limit: limit) { (articles, pagination) in
            let articleViewModels:[ArticleViewModel] = articles.compactMap(ArticleViewModel.init)
            let paginationViewModel = PaginationViewModel(pagination: pagination)
            
            completion(articleViewModels, paginationViewModel)
        }
    }
    
    // Mark: - Request Service to Upload Image to API
    func uploadImagetoAPI(imageData:Data, completion: @escaping (_ image:String) -> Void) {
        ArticleService.shared.uploadImageToAPI(imageData: imageData) { (image) in
            completion(image)
        }
    }
    
    // Mark: - Request service to add new article
    func addNewArticle(article:AddArticleViewModel, completion: @escaping (_ message:String)->Void) {
        ArticleService.shared.addNewArticle(article: article) { (message) in
            completion(message)
        }
    }
}
