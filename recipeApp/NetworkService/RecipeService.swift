//
//  RecipeService.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 11/11/2024.
//
import Moya
import Foundation

protocol RecipeServiceProtocol {
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void)
    func getDish(by id: String, completion: @escaping (Result<Dish, Error>) -> Void)
    func searchRecipes(query: String, completion: @escaping (Result<[Dish], Error>) -> Void)
}

class RecipeService: RecipeServiceProtocol {

    private let provider = MoyaProvider<RecipeApi>()
    private let decoder = JSONDecoder()

    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        provider.request(.getCategories) { result in
            switch result {
            case .success(let response):
                do {
                    let categoriesResponse = try self.decoder.decode(CategoriesResponse.self, from: response.data)
                    completion(.success(categoriesResponse.categories))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getDish(by id: String, completion: @escaping (Result<Dish, Error>) -> Void) {
        provider.request(.getDish(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let dishResponse = try self.decoder.decode(DishResponse.self, from: response.data)
                    completion(.success(dishResponse.dish))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchRecipes(query: String, completion: @escaping (Result<[Dish], Error>) -> Void) {
        provider.request(.getDishByName(query: query)) { result in
            switch result {
            case .success(let response):
                do {
                    let dishes = try self.decoder.decode([Dish].self, from: response.data)
                    completion(.success(dishes))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
