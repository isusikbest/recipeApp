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
        favoritesDishes = []
        favoritesCategories = []
        
        favoritesCategories = loadFavorites(forKey: categoriesKey)
        favoritesDishes = loadFavorites(forKey: dishesKey)
        
        saveDishes()
        saveCategories()
    }
    
    func addCategoryToFavorites(_ id: String) {
        favoritesCategories.insert(id)
        saveCategories()
    }
    
    func removeCategoryFromFavorites(_ id: String) {
        favoritesCategories.remove(id)
        saveCategories()
    }
    
    func isCategoryFavorite(_ id: String) -> Bool {
        return favoritesCategories.contains(id)
    }
    
    func addDishToFavorites(_ id: String) {
        favoritesDishes.insert(id)
        saveDishes()
    }
    
    func removeDishFromFavorites(_ id: String) {
        favoritesDishes.remove(id)
        saveDishes()
    }
    
    func isDishFavorite(_ id: String) -> Bool {
        return favoritesDishes.contains(id)
    }
    
    private func saveCategories() {
        saveFavorites(favoritesCategories, forKey: categoriesKey)
    }
    
    private func saveDishes() {
        saveFavorites(favoritesDishes, forKey: dishesKey)
    }
    
    private func saveFavorites(_ favorites: Set<String>, forKey key: String) {
        let favoritesArray = Array(favorites)
        UserDefaults.standard.set(favoritesArray, forKey: key)
    }
    
    private func loadFavorites(forKey key: String) -> Set<String> {
        let favoritesArray = UserDefaults.standard.stringArray(forKey: key) ?? []
        return Set(favoritesArray)
    }
}
