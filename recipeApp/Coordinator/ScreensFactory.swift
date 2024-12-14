//
//  ScreensFactory.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 25/11/2024.
//
import UIKit

final class ScreensFactory {
    func createRecipeScreen() -> UIViewController {
        let service = RecipeService()
        let viewController = CategoriesView()
        let presenter = CategoriesPresenter(view: viewController, service: service)
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
    func createDishPage() -> UIViewController {
        let viewcontroller = DishView()
        let presenter = DishPresenter(view: viewcontroller as! DishViewProtocol)
        viewcontroller.presenter = presenter
        return viewcontroller
    }
}
