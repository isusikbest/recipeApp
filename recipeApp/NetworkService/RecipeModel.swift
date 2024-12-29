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
    let keyforDish: String
    let id: String
    let name: String
}

struct DishResponse: Decodable {
    let meals: [Dish]
}
enum CodingKeys: String, CodingKey {
    case keyforDish = "meals"
    case id = "idMeal"
    case name = "strMeal"
}
