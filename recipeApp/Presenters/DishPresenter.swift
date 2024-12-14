//
//  DishPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 14/12/2024.
//
import UIKit

protocol DishPresenterProtocol {
    init(view: DishViewProtocol)
}

class DishPresenter: DishPresenterProtocol {
    
    private unowned var view: DishViewProtocol
    
    required init(view: DishViewProtocol) {
        self.view = view
    }
    func loadDish() {
       
    }
}
