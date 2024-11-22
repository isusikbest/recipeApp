//
//  CategoriesPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//

import Foundation


protocol CategoriesPresenterProtocol {
    init(view: CategoriesViewProtocol, data: RecipeServiceProtocol)
}

class CategoriesPresenter: CategoriesPresenterProtocol {
    
    private let view: CategoriesViewProtocol
    private let data: RecipeServiceProtocol
   
    required init(view: CategoriesViewProtocol, data: RecipeServiceProtocol) {
        self.view = view
        self.data = data
    }

    func loadCategories() {
        data.getCategories { result in
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
