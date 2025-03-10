//
//  RecipeService.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 11/11/2024.
//
import Moya
import Combine
import Foundation

protocol RecipeServiceProtocol {
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void)
    func getDish(by id: String, completion: @escaping (Result<Dish, Error>) -> Void)
    func searchRecipes(query: String) -> AnyPublisher<[Dish], Error>
    func getRecipes(in category: String, completion: @escaping (Result<[Dish], Error>) -> Void)
}

class RecipeService: RecipeServiceProtocol {
    
    private let provider = MoyaProvider<RecipeApi>()
    private let decoder = JSONDecoder()
    
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        provider.request(.getCategories) { result in
            
            do {
                let categories = try result
                    .get()
                    .map(CategoriesResponse.self, using: self.decoder)
                    .categories
                completion(.success(categories))
            } catch {
                completion(.failure(error))
            }
            
        }
    }
    
    func getRecipes(in category: String, completion: @escaping (Result<[Dish], Error>) -> Void) {
        provider.request(.getDishByCategory(category: category)) { result in
            
            do {
                let dishes = try result
                    .get()
                    .map(DishResponse.self, using: self.decoder)
                    .meals
                completion(.success(dishes))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getDish(by id: String, completion: @escaping (Result<Dish, Error>) -> Void) {
        provider.request(.getDish(id: id)) { result in
            
            do {
                let dishResponse = try result
                    .get()
                    .map(DishResponse.self, using: self.decoder)
                guard let dish = dishResponse.meals.first else {return}
                completion(.success(dish))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func searchRecipes(query: String) -> AnyPublisher<[Dish], Error> {
        Future<DishResponse, Error> { promise in
            self.provider.request(.getDishByName(query: query)) { result in
                do {
                    let dishesResponse = try result
                        .get()
                        .map(DishResponse.self, using: self.decoder)
                    promise(.success(dishesResponse))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .map { $0.meals }
        .eraseToAnyPublisher()
        
    }
}
