//
//  IngredientService.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/13/23.
//

import Foundation

class IngredientService {
    static let shared = IngredientService()
    private init() {}
    
    private(set) var ingredients: [Ingredient] = []
    
    func add(ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
    
    func deleteAllIngredients() {
        ingredients.removeAll()
    }
}
