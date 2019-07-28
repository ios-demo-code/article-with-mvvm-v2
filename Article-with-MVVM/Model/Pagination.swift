//
//  Pagination.swift
//  Article-with-MVVM
//
//  Created by Soeng Saravit on 7/12/19.
//  Copyright © 2019 KSHRD. All rights reserved.
//

import Foundation
import SwiftyJSON

class Pagination {
    var page:Int?
    var limit:Int?
    var totalCount:Int?
    var totalPages:Int?
    
    init() {}
    
    init(json:JSON) {
        self.page = json["PAGE"].int
        self.limit = json["LIMIT"].int
        self.totalCount = json["TOTAL_COUNT"].int
        self.totalPages = json["TOTAL_PAGES"].int
    }
}
