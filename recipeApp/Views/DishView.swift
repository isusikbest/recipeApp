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

class DishView: UIViewController {
    
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
        guard let presenter = presenter else { return }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: presenter.storage.isDishFavorite(dish.idMeal) ? "heart.fill" : "heart"),
            style: .plain,
            target: self,
            action: #selector(switchFavorite)
        )
    }
    
    @objc func switchFavorite() {
        guard let dish else { return }
        presenter?.toggleFavorite(with: dish)
        setupFavoriteButton()
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
