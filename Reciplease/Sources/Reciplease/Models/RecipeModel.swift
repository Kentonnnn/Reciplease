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
    let id: String
    let label: String
    let image: String?
    let ingredientLines: [String]
    let totalTime: Int?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .uri)
        self.label = try container.decode(String.self, forKey: .label)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.ingredientLines = try container.decode([String].self, forKey: .ingredientLines)
        self.totalTime = try container.decodeIfPresent(Int.self, forKey: .totalTime)
    }

    enum CodingKeys: String, CodingKey {
        case uri
        case label
        case image
        case ingredientLines
        case totalTime
    }
}




