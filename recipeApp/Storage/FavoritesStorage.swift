//
//  FavoritesStorage.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 19/01/2025.
//

class FavoritesStorage {
    
    private var favoritesCategories: Set<String> = []
    private var favoritesDishes: Set<String> = []
    
    func addCategoryToFavorites(_ id: String) {
        favoritesCategories.insert(id)
    }
    
    func removeCategoryFromFavorites(_ id: String) {
        favoritesCategories.remove(id)
    }
    
    func isCategoryFavorite(_ id: String) -> Bool {
        return favoritesCategories.contains(id)
    }
    
    func addDishToFavorites(_ id: String) {
        favoritesDishes.insert(id)
    }
    
    func removeDishFromFavorites(_ id: String) {
        favoritesDishes.remove(id)
    }
    
    func isDishFavorite(_ id: String) -> Bool {
        return favoritesDishes.contains(id)
    }
}
