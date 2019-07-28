//
//  ArticleViewModel.swift
//  Article-with-MVVM
//
//  Created by Soeng Saravit on 7/12/19.
//  Copyright © 2019 KSHRD. All rights reserved.
//

import Foundation

class ArticleViewModel {
    var id:Int?
    var title:String?
    var description:String?
    var createdDate:String?
    var image:String?
    
    init(article:Article) {
        self.id = article.id
        self.title = article.title
        self.description = article.description
        self.createdDate = formatDate(date: article.createdDate!)
        self.image = checkImageURL(imageURL: article.image)
    }
    
    // Mark: - format date
    func formatDate(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        
        if let newDate = dateFormatter.date(from: date) {
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
            
            return newDateFormatter.string(from: newDate)
        }else {
            return ""
        }
    }
    
    // Mark: - Check image url
    func checkImageURL(imageURL:String?) -> String {
        if let url = imageURL {
            return url
        }else {
            return "http://www.api-ams.me:80/image-thumbnails/thumbnail-549ddb1d-ba61-445b-af68-5d898f47d717.png"
        }
    }
}
