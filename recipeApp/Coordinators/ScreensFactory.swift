//
//  ScreensFactory.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 25/11/2024.
//
import UIKit

final class ScreensFactory {
    
    func createRecipeScreen(сoordinator: RecipeCoordinator) -> UIViewController {
        let service = RecipeService()
        let viewController = CategoriesView()
        let presenter = CategoriesPresenter(view: viewController, service: service, coordinator: coordinator)
        viewController.presenter = presenter
        return viewController
    }
    
    func createDishesPage(for category: String) -> UIViewController {
        let service = RecipeService()
        let viewController = CategoryView()
        let presenter = CategoryPresenter(view: viewController, service: service, category: category)
        viewController.presenter = presenter
        return viewController
    }
    
    func createDishPage(by id: String) -> DishView {
        let service = RecipeService()
        let viewcontroller = DishView()
        let presenter = DishPresenter(view: viewcontroller, service: service, id: id)
        viewcontroller.presenter = presenter
        return viewcontroller
    }
//    func createSearchPage() -> UIViewController {
//        let service = RecipeService()
//        let viewController = SearchView()
//        let presenter = SearchPresenter(view: viewController, service: service)
//        viewController.presenter = presenter
//        return viewController
//    }
}
