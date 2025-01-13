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
    
    var presenter: DishPresenter?
    weak var coordinator: RecipeCoordinator?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(strLabel)
        view.addSubview(idLabel)
        setupLayout()
        presenter?.loadDish()
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
        self.strLabel.text = dish.strMeal
        self.idLabel.text = dish.idMeal
    }
}
