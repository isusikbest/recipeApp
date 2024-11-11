//
//  ViewController.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 31/10/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        getCategories { result in
            switch result {
            case .success(let categories):
                for category in categories {
                    print("Category: \(category.strCategory)")
                    print("Description: \(category.strCategoryDescription)")
                    print("Image URL: \(category.strCategoryThumb)")
                }
            case .failure(let error):
                print("Error fetching categories: \(error)")
            }
        }
        
    }
}

