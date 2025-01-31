//
//  SearchPageViewModel.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 15/01/2025.
//
import UIKit
import Combine

class SearchDishViewModel {
    
    @Published var searchText: String = ""
    @Published private(set) var filteredItems: [Dish] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var shouldShowPlaceholderImage: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let service: RecipeService
    private let coordinator: SearchDishCoordinator
    
    init(service: RecipeService, coordinator: SearchDishCoordinator) {
        self.service = service
        self.coordinator = coordinator
        setupBindings()
    }
    
    private func setupBindings() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { query -> AnyPublisher<[Dish]?, Never> in
                if query.isEmpty {
                    return Just(nil).eraseToAnyPublisher()
                } else {
                    self.isLoading = true
                    return self.service.searchRecipes(query: query)
                        .map { Optional($0) }
                        .catch { _ in Just([])}
                        .eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { dishes in
                if let dishes = dishes {
                    self.errorMessage = dishes.isEmpty ? "No results found" : nil
                    self.shouldShowPlaceholderImage = dishes.isEmpty
                    self.filteredItems = dishes.isEmpty ? [] : dishes
                } else {
                    self.isLoading = false
                    self.errorMessage = "Please enter text"
                    self.shouldShowPlaceholderImage = false
                    self.filteredItems = []
                }
            })
            .store(in: &cancellables)
    }
    
    func showDetail(by id: String, delegate: DishViewDelegate) {
        coordinator.showDetails(by: id, delegate: delegate)
    }
}
