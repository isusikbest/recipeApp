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
    case getDish(id: String)
    case getDishByName(query: String)
}

extension RecipeApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.themealdb.com/api/json/v1/1")!
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

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

}
