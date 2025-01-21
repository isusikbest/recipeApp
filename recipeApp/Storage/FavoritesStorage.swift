//
//  FavoritesStorage.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 19/01/2025.
//
import UIKit

class FavoritesStorage {
    private let categoriesKey = "favoritesCategories"
    private let dishesKey = "favoritesDishes"
    
    private var favoritesCategories: Set<String> {
        didSet {
            saveCategories()
        }
    }
    
    private var favoritesDishes: Set<String> {
        didSet {
            saveDishes()
        }
    }
    
    init() {
        self.favoritesCategories = FavoritesStorage.loadFavorites(forKey: categoriesKey)
        self.favoritesDishes = FavoritesStorage.loadFavorites(forKey: dishesKey)
    }
    
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
    
    private func saveCategories() {
        FavoritesStorage.saveFavorites(favoritesCategories, forKey: categoriesKey)
    }
    
    private func saveDishes() {
        FavoritesStorage.saveFavorites(favoritesDishes, forKey: dishesKey)
    }
    
    private static func saveFavorites(_ favorites: Set<String>, forKey key: String) {
        let favoritesArray = Array(favorites)
        UserDefaults.standard.set(favoritesArray, forKey: key)
    }
    
    private static func loadFavorites(forKey key: String) -> Set<String> {
        let favoritesArray = UserDefaults.standard.stringArray(forKey: key) ?? []
        return Set(favoritesArray)
    }
}
