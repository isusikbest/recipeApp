//
//  CategoriesCoordinator.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 09/01/2025.
//

import UIKit
import Combine

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
    
    func showDishesBySelectedCategory(for category: Category, delegate: CategoryPresenterDelegate) {
        let dishesVC = screensFactory.createDishesPage(for: category, coordinator: self, delegate: delegate)
        navigationController.pushViewController(dishesVC, animated: true)
    }
    
    func showDisheDetails(by id: String, delegate: DishPresenterDelegate) {
        let dishVC = screensFactory.createDishPage(by: id, delegate: delegate)
        navigationController.pushViewController(dishVC, animated: true)
    }
}
