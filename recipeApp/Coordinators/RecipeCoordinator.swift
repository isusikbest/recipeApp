//
//  CategoriesCoordinator.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 09/01/2025.
//

import UIKit

class RecipeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let screensFactory: ScreensFactory
    
    init(navigationController: UINavigationController, screensFactory: ScreensFactory) {
        self.navigationController = navigationController
        self.screensFactory = ScreensFactory()
    }
    
    func start() {
        let categorisVC =  self.screensFactory.createRecipeScreen(coordinator: self)
        navigationController.pushViewController(categorisVC, animated: true)
    }
    
    func showDishesBySelectedCategory(for category: Category) {
        let dishesVC = screensFactory.createDishesPage(for: category, coordinator: self)
        if let categoryView = dishesVC as? CategoryView {
                categoryView.delegate = self
            }
        navigationController.pushViewController(dishesVC, animated: true)
       
    }
    
    func showDisheDetails(by id: String) {
        let dishVC = screensFactory.createDishPage(by: id)
        navigationController.pushViewController(dishVC, animated: true)
    }
}
extension RecipeCoordinator: CategoryUpdateDelegate {
    func didUpdateFavorites(for categoryId: String) {
        
    }
    
    
}
