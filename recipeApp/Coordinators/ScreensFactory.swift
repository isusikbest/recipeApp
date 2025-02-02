//
//  ScreensFactory.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 25/11/2024.
//
import UIKit

final class ScreensFactory {
    
    let storage = FavoritesStorage()
    
    func createRecipeScreen(coordinator: RecipeCoordinator) -> UIViewController {
        let service = RecipeService()
        let viewController = CategoriesView()
        let presenter = CategoriesPresenter(view: viewController, service: service, coordinator: coordinator, storage: storage)
        viewController.presenter = presenter
        viewController.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        return viewController
    }
    
    func createDishesPage(for category: Category, coordinator: RecipeCoordinator, delegate: CategoryPresenterDelegate?) -> UIViewController {
        let service = RecipeService()
        let viewController = CategoryView()
        let presenter = CategoryPresenter(view: viewController, service: service, category: category, coordinator: coordinator, storage: storage)
        viewController.configure(with: category)
        viewController.presenter = presenter
        viewController.title = category.strCategory
        return viewController
    }
    
    func createDishPage(by id: String, delegate: DishPresenterDelegate?) -> DishView {
        let service = RecipeService()
        let viewcontroller = DishView()
        let presenter = DishPresenter(view: viewcontroller, service: service, id: id, storage: storage)
        viewcontroller.presenter = presenter
        return viewcontroller
    }
}
