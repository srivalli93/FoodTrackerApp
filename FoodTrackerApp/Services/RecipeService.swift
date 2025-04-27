//
//  APIService.swift
//  FoodTrackerApp
//
//  Created by Srivalli Kanchibotla on 4/25/25.
//

import Foundation


class RecipeService {
    
    func fetchRecipes(completion: @escaping (Result<Recipes, Error>) -> Void) {
        
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "RecipeService", code: -1, userInfo: [NSLocalizedDescriptionKey:"No data returned"])))
                return
            }
            
            do {
                let recipes = try JSONDecoder().decode(Recipes.self, from: data)
                completion(.success(recipes))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
}
