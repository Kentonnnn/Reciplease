//
//  RecipeModel.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/17/23.
//

import Foundation

struct RecipeModel: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    let recipe: Recipes
}

struct Recipes: Decodable {
    let label: String
    let image: String?
    let ingredientLines: [String]
    let totalTime: Int?
    // essayer de trouver la note de la recette 
}


