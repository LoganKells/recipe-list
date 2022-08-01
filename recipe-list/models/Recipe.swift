//
//  Recipe.swift
//  recipe-list
//
//  Created by Logan Kells on 8/1/22.
//

import Foundation

class Recipe: Identifiable, Decodable {
    var id: UUID?
    var name: String
    var featured: Bool
    var image: String
    var description: String
    var prepTime: String
    var cookTime: String
    var servings: Int
    var ingredients: [String]
    var directions: [String]
    
    init(name: String, featured: Bool, image: String, description: String, prepTime: String, cookTime: String, servings: Int, ingredients: [String], directions: [String]) {
        self.name = name
        self.featured = featured
        self.image = image
        self.description = description
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.servings = servings
        self.ingredients = ingredients
        self.directions = directions
    }
    
}
