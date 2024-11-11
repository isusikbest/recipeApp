//
//  ServiceManager.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 11/11/2024.
//

import Moya
import Foundation


enum RecipeApi {
    case getCategories
    case getDish
    case getDishByName(query: String)
}


extension RecipeApi: TargetType {
    var baseURL: URL {
        return URL(string:  "https://www.themealdb.com/api/json/v1/1")!
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return "/categories.php"
        case .getDish:
            return "random.php"
        case .getDishByName:
            return "search.php?s=Arrabiata"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getCategories:
            return .requestPlain
            
        case .getDish:
            return .requestPlain
        case .getDishByName(let query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}

let provider = MoyaProvider<RecipeApi>()

func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
    provider.request(.getCategories) { result in
        switch result {
        case .success(let response):
            do {
                let categoriesResponse = try JSONDecoder().decode(CategoriesResponse.self, from: response.data)
                completion(.success(categoriesResponse.categories))
            } catch {
                completion(.failure(error))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}


