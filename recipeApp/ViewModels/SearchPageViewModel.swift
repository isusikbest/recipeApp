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
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }

    private func performSearch(query: String) {
        guard !query.isEmpty else {
            self.filteredItems = []
            self.shouldShowPlaceholderImage = true
            self.errorMessage = "Please enter text"
            return
        }

        isLoading = true
        service.searchRecipes(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure = completion {
                    self?.errorMessage = "No results found"
                    self?.shouldShowPlaceholderImage = true
                    self?.filteredItems = []
                }
            }, receiveValue: { [weak self] dishes in
                self?.isLoading = false
                if dishes.isEmpty {
                    self?.errorMessage = "No results found"
                    self?.shouldShowPlaceholderImage = true
                } else {
                    self?.shouldShowPlaceholderImage = false
                    self?.errorMessage = nil
                    self?.filteredItems = dishes
                }
            })
            .store(in: &cancellables)
    }
    
    func showDetail(by id: String) {
        coordinator.showDetails(by: id)
    }
}
