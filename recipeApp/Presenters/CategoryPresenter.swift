//
//  CategoryPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 27/11/2024.
//
import UIKit

protocol CategoryPresenterProtocol {
    init(view: CategoryViewProtocol, service: RecipeServiceProtocol, category: String, coordinator: RecipeCoordinator?)
}

class CategoryPresenter: CategoryPresenterProtocol {
   
    private unowned let view: CategoryViewProtocol
    private let service: RecipeServiceProtocol
    private let category: String
    private let coordinator: RecipeCoordinator?
    
    required init(view: CategoryViewProtocol, service: RecipeServiceProtocol, category: String, coordinator: RecipeCoordinator?) {
        self.view = view
        self.service = service
        self.category = category
        self.coordinator = coordinator
    }
    
    func showDishes(by id: String) {
        coordinator?.showDisheDetails(by: id)
    }
    
    func loadDishes() {
        service.getRecipes(in: category, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dishes):
                    let disheNames = dishes
                    self?.view.showDishes(dishes: disheNames)
                case .failure(let error):
                    print("Failed to fetch meals: \(error)")
                }
            }
        })
    }
}
