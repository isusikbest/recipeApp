//
//  AppCoordinator.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 09/01/2025.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let tabBarController: UITabBarController
    let screensFactory: ScreensFactory
    
    init(tabBarController: UITabBarController, screensFactory: ScreensFactory) {
        self.tabBarController = tabBarController
        self.screensFactory = screensFactory
    }
    
    func start() {
        let tabBarCoordinator = TabBarCoordinator(tabBarController: tabBarController, screenFactory: screensFactory)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
