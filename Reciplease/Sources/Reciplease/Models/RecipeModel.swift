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

struct Recipes: Codable {
    let label: String
    let image: String?
    let ingredientLines: [String]
    let totalTime: Int?
    let yield: Int?
    let uri: String
    
    // Ajoutez d'autres propriétés nécessaires selon vos besoins
    
    enum CodingKeys: String, CodingKey {
        case label, image, ingredientLines, totalTime, yield, uri
    }
}
