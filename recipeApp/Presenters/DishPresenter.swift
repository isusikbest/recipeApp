//
//  DishPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 14/12/2024.
//
import UIKit

protocol DishPresenterProtocol {
    init(view: DishViewProtocol, service: RecipeServiceProtocol, id: String, storage: FavoritesStorage)
}

protocol DishPresenterDelegate: AnyObject {
    func didUpdateDishFavorites(for dishId: String)
}

class DishPresenter: DishPresenterProtocol {
    
    var delegate: DishPresenterDelegate?
    private unowned var view: DishViewProtocol
    private let service: RecipeServiceProtocol
    private let id: String
    let storage: FavoritesStorage
    
    required init(view: DishViewProtocol, service: RecipeServiceProtocol, id: String, storage: FavoritesStorage) {
        self.view = view
        self.service = service
        self.id = id
        self.storage = storage
    }
    
    func toggleFavorite(with dish: Dish) {
        if storage.isDishFavorite(dish.idMeal) {
            storage.removeDishFromFavorites(dish.idMeal)
        } else {
            storage.addDishToFavorites(dish.idMeal)
        }
        delegate?.didUpdateDishFavorites(for: dish.idMeal)
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
