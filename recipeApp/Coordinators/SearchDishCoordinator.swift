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
    let service: RecipeService
    let screenFactory: ScreensFactory
    
    init(navigationController: UINavigationController, service: RecipeService, screenFactory: ScreensFactory) {
        self.navigationController = navigationController
        self.service = service
        
        self.screenFactory = screenFactory
    }
    
    func showDetails(by id: String, delegate: DishPresenterDelegate) {
        let dishVC = screenFactory.createDishPage(by: id, delegate: delegate)
        navigationController.pushViewController(dishVC, animated: true)
    }
    
    func start() {
        let viewModel = SearchDishViewModel(service: service, coordinator: self)
        let searchdishVC = SearchDishView(viewModel: viewModel)
        navigationController.pushViewController(searchdishVC, animated: true)
    }
}
