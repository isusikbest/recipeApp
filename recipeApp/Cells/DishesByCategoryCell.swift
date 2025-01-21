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
    
    private let favoriteIcon = UIImageView().then {
        $0.image = UIImage(systemName: "heart.fill")
        $0.tintColor = .systemBlue
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteIcon)
        setupUI()
        setupCell()
    }
    
    func setupUI() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        favoriteIcon.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
            make.width.height.equalTo(20)
        }
    }
    
    func configure(with dish: Dish, isFavorite: Bool) {
        titleLabel.text = dish.strMeal
        favoriteIcon.isHidden = !isFavorite
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
