//
//  RecipeService.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/17/23.
//

import Foundation

class RecipeService {
    static let shared = RecipeService()
    private init() {}
    
    private(set) var recipes: [Recipe] = []
    
    func add(recipe: Recipe) {
        recipes.append(recipe)
    }
}
