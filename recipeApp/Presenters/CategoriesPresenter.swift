//
//  CategoriesPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//

protocol CategoriesPresenterProtocol {
    init(view: CategoriesViewProtocol, service: RecipeServiceProtocol, coordinator: RecipeCoordinator?, storage: FavoritesStorage)
}

class CategoriesPresenter: CategoriesPresenterProtocol {
   
    private unowned let view: CategoriesViewProtocol
    private let service: RecipeServiceProtocol
    private let coordinator: RecipeCoordinator?
    let storage: FavoritesStorage
   
    required init(view: CategoriesViewProtocol, service: RecipeServiceProtocol, coordinator: RecipeCoordinator?, storage: FavoritesStorage) {
        self.view = view
        self.service = service
        self.coordinator = coordinator
        self.storage = storage
    }
    
    func showDishes(for category: Category, delegate: CategoryPresenterDelegate) {
        coordinator?.showDishesBySelectedCategory(for: category, delegate: delegate)
    }

    func loadCategories() {
        service.getCategories { result in
            switch result {
            case .success(let categories):
                self.view.showData(data: categories)
            case .failure(let error):
                print("Something wrong: \(error.localizedDescription)")
            }
        }
    }
}
