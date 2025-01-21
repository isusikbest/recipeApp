//
//  DishView.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 14/12/2024.
//
import UIKit
import SnapKit
import Then

protocol DishViewProtocol: AnyObject {
    func showDish(dish: Dish)
}

protocol DishViewDelegate: AnyObject {
    func didUpdateDishFavorites(for dishId: String)
}

class DishView: UIViewController {
    
    var delegate: DishViewDelegate?
    private let storage = FavoritesStorage.shared
    
    private var strLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    private var idLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    var dish: Dish?
    var presenter: DishPresenter?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(strLabel)
        view.addSubview(idLabel)
        setupLayout()
        presenter?.loadDish()
    }
    
    private func setupFavoriteButton() {
        guard let dish = dish else { return }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: storage.isDishFavorite(dish.idMeal) ? "heart.fill" : "heart"),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite)
        )
    }
    
    @objc private func toggleFavorite() {
           guard let dish = dish else { return }
           if storage.isDishFavorite(dish.idMeal) {
               storage.removeDishFromFavorites(dish.idMeal)
           } else {
               storage.addDishToFavorites(dish.idMeal)
           }
           setupFavoriteButton()
           delegate?.didUpdateDishFavorites(for: dish.idMeal)
       }

    func setupLayout() {
        strLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(strLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
}

extension DishView: DishViewProtocol {
    func showDish(dish: Dish) {
        self.dish = dish
        self.strLabel.text = dish.strMeal
        self.idLabel.text = dish.idMeal
        setupFavoriteButton()
    }
}
