//
//  CategoryPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 27/11/2024.
//
import Foundation
import UIKit

protocol CategoryPresenterProtocol {
    init(view: CategoryViewProtocol, service: RecipeServiceProtocol, category: String)
}

class CategoryPresenter: CategoryPresenterProtocol {
   
    private unowned let view: CategoryViewProtocol
    private let service: RecipeServiceProtocol
    private let category: String
    
    required init(view: CategoryViewProtocol, service: RecipeServiceProtocol, category: String) {
        self.view = view
        self.service = service
        self.category = category
    }
    
    func loadDishes() {
        service.getRecipes(in: category, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dishes):
                    let disheNames = dishes.map {$0.strMeal}
                    self?.view.showDishes(dishes: disheNames)
                case .failure(let error):
                    print("Failed to fetch meals: \(error)")
                }
            }
        })
    }
}
