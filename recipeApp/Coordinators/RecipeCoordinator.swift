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
    var cancellables = Set<AnyCancellable>()
    let categoriesVC: CategoriesView = CategoriesView()
    
    init(navigationController: UINavigationController, screensFactory: ScreensFactory) {
        self.navigationController = navigationController
        self.screensFactory = ScreensFactory()
    }
    
    func start() {
        let categorisVC =  self.screensFactory.createRecipeScreen(coordinator: self)
        navigationController.pushViewController(categorisVC, animated: true)
    }
    
    func showDishesBySelectedCategory(for category: Category) {
        if let categoriesVC = navigationController.topViewController as? CategoriesView {
            print("Categories found")
        } else {
            print("CategoriesView is not set")
            return
        }
        let dishesVC = screensFactory.createDishesPage(for: category, coordinator: self, delegate: categoriesVC)
        navigationController.pushViewController(dishesVC, animated: true)
    }
    
    func showDisheDetails(by id: String) {
        let dishVC = screensFactory.createDishPage(by: id)
        navigationController.pushViewController(dishVC, animated: true)
    }
}


