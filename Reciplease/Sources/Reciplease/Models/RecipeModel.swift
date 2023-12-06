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
    // trouver la note de la recette
    // toruver le lien pour chaque recette
}


