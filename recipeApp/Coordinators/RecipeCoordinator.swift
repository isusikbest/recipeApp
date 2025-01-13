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
       let categoriesVC = self.screensFactory.createRecipeScreen()
        navigationController.pushViewController(categoriesVC, animated: true)
        categoriesVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
    }
    
    func showDishesBySelectedCategory(for category: String) {
        let dishesVC = screensFactory.createDishesPage(for: category)
        navigationController.pushViewController(dishesVC, animated: true)
        dishesVC.title = category
    }
    
    func showDisheDetails(by id: String) {
        let dishVC = screensFactory.createDishPage(by: id)
        navigationController.pushViewController(dishVC, animated: true)
    }
}
