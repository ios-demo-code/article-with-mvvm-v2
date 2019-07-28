//
//  AddArticleViewController.swift
//  Article-with-MVVM
//
//  Created by Soeng Saravit on 7/28/19.
//  Copyright © 2019 KSHRD. All rights reserved.
//

import UIKit

class AddArticleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var imagePicker:UIImagePickerController?
    var articleListViewModel:ArticleListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articleListViewModel = ArticleListViewModel()
    }
    
    @IBAction func browseImage(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = false
        imagePicker?.sourceType = .photoLibrary
        
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            articleImageView.image = image
        }
        self.imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveArticle(_ sender: Any) {
        let imageData = UIImage.jpegData(self.articleImageView.image!)(compressionQuality: 0.5)
        let article = AddArticleViewModel()
        self.articleListViewModel?.uploadImagetoAPI(imageData: imageData!, completion: { (image) in
            article.image = image
            article.title = self.titleTextField.text
            article.description = self.descriptionTextView.text
            
            self.articleListViewModel?.addNewArticle(article: article, completion: { (message) in
                print(message)
            })
        })
    }
    
}
