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
    
    private let strLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.textColor = .black
    }
    private let idLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    var presenter: DishPresenter?
    var titleLabel: String?
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(strLabel)
        view.addSubview(idLabel)
        presenter?.loadDish()
        setupText()
        setupLayout()
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
    
    func setupText() {
        strLabel.text = titleLabel
        idLabel.text = "id:\(id ?? "Unknown")"
    }
}

extension DishView: DishViewProtocol {
    func showDish(dish: Dish) {
        self.titleLabel = dish.strMeal
        self.id = dish.idMeal
    }
}
