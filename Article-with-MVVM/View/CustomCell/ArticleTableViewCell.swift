//
//  ArticleTableViewCell.swift
//  Article-with-MVVM
//
//  Created by Soeng Saravit on 7/15/19.
//  Copyright © 2019 KSHRD. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artilceImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Mark: - Bind data to table view cell
    func bindData(articleViewModel: ArticleViewModel) {
        titleLabel.text = articleViewModel.title
        descriptionLabel.text = articleViewModel.description
        createdDateLabel.text = articleViewModel.createdDate
        
        if let url = URL(string: articleViewModel.image!){
            artilceImageView?.kf.setImage(with: url, placeholder: UIImage(named: "default-img"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }

}
