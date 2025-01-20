//
//  RecipeModel.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 11/11/2024.
//

struct Category: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
    var isFavorite: Bool = false
}
    struct CategoriesResponse: Decodable {
        let categories: [Category]
    }
    
    struct Dish: Decodable {
        let idMeal: String
        let strMeal: String
        var isFavorite: Bool = false
    }
    
    struct DishResponse: Decodable {
        let meals: [Dish]
    }

