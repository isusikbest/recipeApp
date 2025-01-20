//
//  CategoriesPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//
protocol CategoriesPresenterProtocol {
    init(view: CategoriesViewProtocol, service: RecipeServiceProtocol, coordinator: RecipeCoordinator?)
}

class CategoriesPresenter: CategoriesPresenterProtocol {

    private unowned let view: CategoriesViewProtocol
    private let service: RecipeServiceProtocol
    private let coordinator: RecipeCoordinator?
   
    required init(view: CategoriesViewProtocol, service: RecipeServiceProtocol, coordinator: RecipeCoordinator?) {
        self.view = view
        self.service = service
        self.coordinator = coordinator
    }
    
    func showCategories(for category: String) {
        coordinator?.showDishesBySelectedCategory(for: category)
    }

    func loadCategories() {
        service.getCategories { result in
            switch result {
            case .success(let categories):
                let categoryNames = categories.map {$0.strCategory}
                self.view.showData(data: categoryNames)
            case .failure(let error):
                print("Something wrong: \(error.localizedDescription)")
//                print(error.description)
            }
        }
    }
}
