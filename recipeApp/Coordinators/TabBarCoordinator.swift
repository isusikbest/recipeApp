//
//  TabBarCoordinator.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 09/01/2025.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let tabBarController: UITabBarController
    let screenFactory: ScreensFactory
    
     init(tabBarController: UITabBarController, screenFactory: ScreensFactory) {
        self.tabBarController = tabBarController
        self.screenFactory = screenFactory
    }
    
    func start() {
        let categoriesNavController = UINavigationController()
        let categoriesCoordinator = RecipeCoordinator(navigationController: categoriesNavController, screensFactory: screenFactory)
        childCoordinators.append(categoriesCoordinator)
        categoriesCoordinator.start()
        
        let searchNavController = UINavigationController()
        let searchCoordinator = SearchDishCoordinator(navigationController: searchNavController)
        childCoordinators.append(searchCoordinator)
        searchCoordinator.start()
        
        tabBarController.viewControllers = [categoriesNavController, searchNavController]
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .gray
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .black
        tabBarController.selectedIndex = 1
        
        searchNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
    }
}
