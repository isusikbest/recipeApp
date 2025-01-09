//
//  AppCoordinator.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 09/01/2025.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let screensFactory: ScreensFactory
    
    init(navigationController: UINavigationController, screensFactory: ScreensFactory) {
        self.navigationController = navigationController
        self.screensFactory = screensFactory
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let tabBarCoordinator = TabBarCoordinator(tabBarController: tabBarController, screenFactory: screensFactory)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
