//
//  RecipeNetwork.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/17/23.
//

import Foundation
import Alamofire

class RecipeNetwork {
    static let shared = RecipeNetwork()
    
    private let baseURL = "https://api.edamam.com/api/recipes/v2"
    private let appID = "0a94a0ca"
    private let appKey = "b256874184e7b193277e16d3c7b4ec85"
    
    func searchRecipes(query: String, completion: @escaping (Result<[Recipes], Error>) -> Void) {
        print("Search Recipes for query: \(query)")

        let urlString = "\(baseURL)?type=public&q=\(query)&app_id=\(appID)&app_key=\(appKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        AF.request(url).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let recipes = try decoder.decode(RecipeModel.self, from: data)
                        completion(.success(recipes.hits.map { $0.recipe }))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.noData))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

enum NetworkError: Error {
    case invalidURL
    case noData
}

