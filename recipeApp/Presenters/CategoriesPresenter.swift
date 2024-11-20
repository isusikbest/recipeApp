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
    
}
