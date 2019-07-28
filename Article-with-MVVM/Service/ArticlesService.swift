//
//  ArticlesService.swift
//  Article-with-MVVM
//
//  Created by Soeng Saravit on 7/12/19.
//  Copyright © 2019 KSHRD. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ArticleService {
    
    // Defined shared instance
    static let shared = ArticleService()
    
    let BASE_URL = "http://www.api-ams.me"
    let headers:[String:String] = [
        "Content-Type":"application/json",
        "Accept":"application/json"
    ]
    
    // Mark: - Fetch Article Data from API
    func fetchArticles(page:Int, limit:Int, completion:@escaping (_ articles:[Article], _ pagination:Pagination)->Void ) {
        
        let GET_ARTICLE_URL = BASE_URL + "/v1/api/articles?page=\(page)&limit=\(limit)"
        
        Alamofire.request(GET_ARTICLE_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                if let data = response.data {
                    let json = try? JSON(data: data)
                    
                    var articles = [Article]()
                    for articleJSON in json!["DATA"].array! {
                        articles.append(Article(json: articleJSON))
                    }
                    let pagination = Pagination(json: json!["PAGINATION"])
                    
                    completion(articles, pagination)
                }
            }
        }
    }
    
    // Mark: - Upload image to API
    func uploadImageToAPI(imageData:Data, completion: @escaping (_ image:String)->Void) {
        let UPLOAD_IMAGE_URL = BASE_URL + "/v1/api/uploadfile/single"
        
        Alamofire.upload(multipartFormData: { (multipart) in
            multipart.append(imageData, withName: "FILE", fileName: ".jpg", mimeType: "image/jpeg")
        }, to: UPLOAD_IMAGE_URL, method:.post, headers:headers) { (result) in
            switch result{
            case .success(request: let request, streamingFromDisk: _, streamFileURL: _):
                request.responseJSON(completionHandler: { (response) in
                    if response.result.isSuccess {
                        if let data = response.data {
                            let json = try? JSON(data: data)
                            let image = json!["DATA"].string
                            completion(image!)
                        }
                    }
                })
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    // Mark: - Add new article to API
    func addNewArticle(article:AddArticleViewModel, comletion: @escaping (_ message:String)->Void) {
        let ADD_ARTICLE_URL = BASE_URL + "/v1/api/articles"
        
        let parameters:[String:Any?] = [
            "TITLE": article.title,
            "DESCRIPTION": article.description,
            "AUTHOR": 1,
            "CATEGORY_ID": 1,
            "STATUS": "1",
            "IMAGE": article.image
        ]
        
        Alamofire.request(ADD_ARTICLE_URL, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                comletion("Add new article successfully!")
            }else {
                comletion("Failed to add new article!")
            }
        }
        
    }
}
