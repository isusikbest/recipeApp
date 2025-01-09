//
//  CategoriesCoordinator.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 09/01/2025.
//

import UIKit

class CategoriesCoordinator: Coordinator {
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
    }
}
