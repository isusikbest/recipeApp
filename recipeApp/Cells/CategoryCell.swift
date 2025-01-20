//
//  CategoryCell.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 19/01/2025.
//
import UIKit

class CategoryCell: UITableViewCell {
    
    func configure(with category: String, isFavorite: Bool) {
        self.textLabel?.text = category
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.5
        accessoryView = isFavorite ? UIImageView(image: UIImage(systemName: "heart.fill")) : nil
    }
}
