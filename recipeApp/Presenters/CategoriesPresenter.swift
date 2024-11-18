//
//  CategoriesPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//

import Foundation

protocol CategoriesPresenterProtocol {
    init(view: CategoriesViewProtocol, data: CategoriesResponse)
}

class CategoriesPresenter: CategoriesPresenterProtocol {
    
    unowned let view: CategoriesView
    let data: CategoriesResponse
    required init(view: CategoriesViewProtocol, data: CategoriesResponse) {
        self.view = view as! CategoriesView
        self.data = data
    }
    
  
    
    
    
    
}
