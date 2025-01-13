//
//  SearchDishCoordinator.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 13/01/2025.
//

import UIKit

class SearchDishCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchdishVC = SearchDishView()
        navigationController.pushViewController(searchdishVC, animated: true)
    }
}
