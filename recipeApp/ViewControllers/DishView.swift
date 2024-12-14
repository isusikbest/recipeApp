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
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(strLabel)
        view.addSubview(idLabel)
        strLabel.snp.makeConstraints { make in
            make.edges.centerY.equalToSuperview()
            make.edges.centerX.equalToSuperview()
        }
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(strLabel as ConstraintRelatableTarget).offset(8)
        }
        if titleLabel == titleLabel {
            strLabel.text = titleLabel
        }
        if idLabel == idLabel {
            idLabel.text = id
        }
    }
    var presenter: DishPresenter?
    var titleLabel: String?
    var id: String?
}
extension DishView: DishViewProtocol {
    func showDish(dish: Dish) {
        self.titleLabel = dish.strMeal
        self.id = dish.idMeal
    }
}
