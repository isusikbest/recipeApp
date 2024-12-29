//
//  MealsByCategoryCell.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 01/12/2024.
//

import UIKit
import Then
import SnapKit

final class DishesByCategoryCell: UICollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        setupTitle()
        setupCell()
    }
    func setupTitle() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    func configure(with dish: Dish) {
        titleLabel.text = dish.name
    }
    func setupCell() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
