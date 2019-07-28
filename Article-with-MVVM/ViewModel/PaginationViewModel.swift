//
//  PaginationViewModel.swift
//  Article-with-MVVM
//
//  Created by Soeng Saravit on 7/12/19.
//  Copyright © 2019 KSHRD. All rights reserved.
//

import Foundation

class PaginationViewModel {
    var totalCount:Int?
    
    init(pagination:Pagination) {
        self.totalCount = pagination.totalCount
    }
}
