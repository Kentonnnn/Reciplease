//
//  FavoriteRecipe.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 12/15/23.
//

import Foundation

class FavoriteRecipes {
    static let shared = FavoriteRecipes()

    private var favoriteRecipes: [Recipes] = []

    func addRecipeToFavorites(_ recipe: Recipes) {
        // Vérifiez si la recette n'est pas déjà dans la liste des favoris
        if !favoriteRecipes.contains(where: { $0.id == recipe.id }) {
            favoriteRecipes.append(recipe)
        }
    }

    func removeRecipeFromFavorites(_ recipe: Recipes) {
        favoriteRecipes.removeAll { $0.id == recipe.id }
    }

    func isRecipeFavorite(_ recipe: Recipes) -> Bool {
        return favoriteRecipes.contains(where: { $0.id == recipe.id })
    }

    func getFavoriteRecipes() -> [Recipes] {
        return favoriteRecipes
    }
}
