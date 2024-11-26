//
//  CategoriesPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//

import Foundation

protocol CategoriesPresenterProtocol {
    init(view: CategoriesViewProtocol, service: RecipeServiceProtocol)
}

class CategoriesPresenter: CategoriesPresenterProtocol {
    
    private unowned let view: CategoriesViewProtocol
    private let service: RecipeServiceProtocol
   
    required init(view: CategoriesViewProtocol, service: RecipeServiceProtocol) {
        self.view = view
        self.service = service
    }

    func loadCategories() {
        service.getCategories { result in
            switch result {
            case .success(let categories):
                let categoryNames = categories.map {$0.strCategory}
                self.view.showData(data: categoryNames)
            case .failure(let error):
                print("Something wrong: \(error.localizedDescription)")
            }
        }
    }
}
