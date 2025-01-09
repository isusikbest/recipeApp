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
        let categoriesCoordinator = CategoriesCoordinator(navigationController: categoriesNavController, screensFactory: screenFactory)
        childCoordinators.append(categoriesCoordinator)
        categoriesCoordinator.start()
        let searchNavController = UINavigationController()
        tabBarController.viewControllers = [categoriesNavController, searchNavController]
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .gray
        searchNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        categoriesNavController.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
    }
}
