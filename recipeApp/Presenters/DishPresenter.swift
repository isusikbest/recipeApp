//
//  DishPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 14/12/2024.
//
import UIKit

protocol DishPresenterProtocol {
    init(view: DishViewProtocol, service: RecipeServiceProtocol, id: String, dish: Dish)
}

class DishPresenter: DishPresenterProtocol {
    
    private unowned var view: DishViewProtocol
    private let service: RecipeServiceProtocol
    private let id: String
    var dish: Dish?
    
    required init(view: DishViewProtocol, service: RecipeServiceProtocol, id: String, dish: Dish) {
        self.view = view
        self.service = service
        self.id = id
        self.dish = dish
    }
    
    func loadDish() {
        service.getDish(by: id) { result in
            switch result {
            case .success(let dish):
                self.view.showDish(dish: dish)
            case .failure(let error):
                print("Something wrong: \(error.localizedDescription)")
            }
        }
    }
}
