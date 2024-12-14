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
    private let label = UILabel().then {
        $0.snp.makeConstraints { make in
            make.edges.centerX.equalToSuperview()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
    }
    var presenter: DishPresenter?
    
}
