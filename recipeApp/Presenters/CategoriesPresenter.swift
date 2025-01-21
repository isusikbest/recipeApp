//
//  CategoriesPresenter.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//
import Combine

protocol CategoriesPresenterProtocol {
    var favoritsUpdate: PassthroughSubject<String, Never> { get }
    
    init(view: CategoriesViewProtocol, service: RecipeServiceProtocol, coordinator: RecipeCoordinator?)
}

class CategoriesPresenter: CategoriesPresenterProtocol {
   
    private unowned let view: CategoriesViewProtocol
    private let service: RecipeServiceProtocol
    private let coordinator: RecipeCoordinator?
   
    var favoritsUpdate = PassthroughSubject<String, Never>()
    var cancellables: Set<AnyCancellable> = []
    
    required init(view: CategoriesViewProtocol, service: RecipeServiceProtocol, coordinator: RecipeCoordinator?) {
        self.view = view
        self.service = service
        self.coordinator = coordinator
    }
    
    func showCategories(for category: Category) {
        let categoryView = CategoryView()
        categoryView.favoritesUpdated
            .sink { [weak self] updatedCategoryId in
                print("Presenter received")
                self?.favoritsUpdate.send(updatedCategoryId)
            }
            .store(in: &cancellables)
        coordinator?.showDishesBySelectedCategory(for: category)
        
    }

    func loadCategories() {
        service.getCategories { result in
            switch result {
            case .success(let categories):
//                _ = categories.map {$0.strCategory}
                self.view.showData(data: categories)
            case .failure(let error):
                print("Something wrong: \(error.localizedDescription)")
//                print(error.description)
            }
        }
    }
}
