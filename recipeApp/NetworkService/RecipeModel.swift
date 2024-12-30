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
}

struct CategoriesResponse: Decodable {
    let categories: [Category]
}

struct Dish: Decodable {
    let idMeal: String
    let strMeal: String
//    let strCategory: String
//    let strInstructions: String
//    let strMealThumb: String
}

struct DishResponse: Decodable {
    let meals: [Dish]
}
