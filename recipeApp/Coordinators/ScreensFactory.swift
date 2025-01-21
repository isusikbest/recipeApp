//
//  ScreensFactory.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 25/11/2024.
//
import UIKit

final class ScreensFactory {
    
    func createRecipeScreen(coordinator: RecipeCoordinator) -> UIViewController {
        let service = RecipeService()
        let viewController = CategoriesView()
        let presenter = CategoriesPresenter(view: viewController, service: service, coordinator: coordinator)
        viewController.presenter = presenter
        viewController.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        return viewController
    }
    
    func createDishesPage(for category: Category, coordinator: RecipeCoordinator) -> UIViewController {
        let service = RecipeService()
        let viewController = CategoryView()
        let presenter = CategoryPresenter(view: viewController, service: service, category: category, coordinator: coordinator)
        viewController.configure(with: category, presenter: presenter)
        viewController.presenter = presenter
        viewController.title = category.strCategory
        
        return viewController
    }
    
    func createDishPage(by id: String) -> DishView {
        let service = RecipeService()
        let viewcontroller = DishView()
        let presenter = DishPresenter(view: viewcontroller, service: service, id: id)
        viewcontroller.presenter = presenter
        return viewcontroller
    }
}
