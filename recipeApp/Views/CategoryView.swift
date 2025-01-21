//
//  CategoryView.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 27/11/2024.
//

import UIKit
import SnapKit
import Then
import Combine

protocol CategoryViewProtocol: AnyObject {
    func showDishes(dishes: [Dish])
}

protocol CategoryViewDelegate: AnyObject {
    func didUpdateFavorites(for categoryId: String)
}

class CategoryView: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.register(DishesByCategoryCell.self, forCellWithReuseIdentifier: "DishesByCategoryCell")
    }
    
    var delegate: CategoryViewDelegate?
    private var dishes: [Dish] = []
    var presenter: CategoryPresenter?
    private let storage = FavoritesStorage.shared
    var category: Category?

    func configure(with category: Category) {
            self.category = category
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter?.loadDishes()
        view.backgroundColor = .white
        setupFavoriteButton()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupFavoriteButton() {
        guard let category else { return }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                    image: UIImage(systemName: storage.isCategoryFavorite(category.idCategory) ? "heart.fill" : "heart"),
                    style: .plain,
                    target: self,
                    action: #selector(toggleFavorite)
                )
    }
    
    @objc func toggleFavorite() {
        guard let category else { return }
        if storage.isCategoryFavorite(category.idCategory) {
            storage.removeCategoryFromFavorites(category.idCategory)
        } else {
            storage.addCategoryToFavorites(category.idCategory)
        }
        setupFavoriteButton()
        delegate?.didUpdateFavorites(for: category.idCategory)
    }
}

extension CategoryView: CategoryViewProtocol {
    func showDishes(dishes: [Dish]) {
        self.dishes = dishes
        collectionView.reloadData()
    }
}

extension CategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishesByCategoryCell", for: indexPath) as? DishesByCategoryCell else {  fatalError("Failed to dequeue DishesByCategoryCell")
        }
        let dish = dishes[indexPath.row]
        let isFavorite = storage.isDishFavorite(dish.idMeal)
        cell.configure(with: dish, isFavorite: isFavorite)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDish = dishes[indexPath.row]
        presenter?.showDishes(by: selectedDish.idMeal, delegate: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let numberOfColumns: CGFloat = 3
           let totalWidth = collectionView.bounds.width
           let spacing: CGFloat = 10
           let calculatedWidth = (totalWidth - (numberOfColumns - 1) * spacing) / numberOfColumns
           return CGSize(width: calculatedWidth, height: calculatedWidth)
    }
}

extension CategoryView: DishViewDelegate {
    func didUpdateDishFavorites(for dishId: String) {
        collectionView.reloadData()
    }
}
