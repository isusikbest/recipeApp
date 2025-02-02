//
//  CategoryPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 27/11/2024.
//
import UIKit

protocol CategoryPresenterProtocol {
    init(view: CategoryViewProtocol, service: RecipeServiceProtocol, category: Category, coordinator: RecipeCoordinator?, storage: FavoritesStorage)
}

protocol CategoryPresenterDelegate: AnyObject {
    func didUpdateFavorites(for categoryId: String)
}

class CategoryPresenter: CategoryPresenterProtocol {
    
    private unowned let view: CategoryViewProtocol
    private let service: RecipeServiceProtocol
    let category: Category
    private let coordinator: RecipeCoordinator?
    let storage: FavoritesStorage
    var delegate: CategoryPresenterDelegate?
    
    required init(view: CategoryViewProtocol, service: RecipeServiceProtocol, category: Category, coordinator: RecipeCoordinator?, storage: FavoritesStorage) {
        self.view = view
        self.service = service
        self.category = category
        self.coordinator = coordinator
        self.storage = storage
    }
    
    func toggleFavorite() {
        if storage.isCategoryFavorite(category.idCategory) {
            storage.removeCategoryFromFavorites(category.idCategory)
        } else {
            storage.addCategoryToFavorites(category.idCategory)
        }
        delegate?.didUpdateFavorites(for: category.idCategory)
    }
        
    func showDishes(by id: String, delegate: DishPresenterDelegate) {
            coordinator?.showDisheDetails(by: id, delegate: delegate)
        }
        
        func loadDishes() {
            service.getRecipes(in: category.strCategory, completion: { [weak self] result in
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
