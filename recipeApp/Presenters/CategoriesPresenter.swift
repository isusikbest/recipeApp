//
//  CategoriesPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//

import Foundation

protocol CategoriesPresenterProtocol {
    init(view: CategoriesView, data: CategoriesResponse)
}

class CategoriesPresenter: CategoriesPresenterProtocol {
    
    let view: CategoriesView
    let data: CategoriesResponse
    
    required init(view: CategoriesView, data: CategoriesResponse) {
        self.view = view
        self.data = data
    }
    
    
}
