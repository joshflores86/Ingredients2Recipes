//
//  OnlineRecipeModel.swift
//  Ingredients2Recipes
//
//  Created by Josh Flores on 5/23/24.
//

import Foundation
import UIKit

class OnlineRecipeModel: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var ingredient: [OnlineIngredientModel]
    var instructions: String
    var timeHours: Int
    var timeMinute: Int
    var favorite: Bool
    
    
    init( name: String, ingredient: [OnlineIngredientModel], instructions: String, timeHours: Int, timeMinute: Int, favorite: Bool) {
        self.name = name
        self.ingredient = ingredient
        self.instructions = instructions
        self.timeHours = timeHours
        self.timeMinute = timeMinute
        self.favorite = favorite
    }
    
}
class OnlineIngredientModel: Codable {
    
    var ingredients: String
    var unit: UnitOfMeasure
    var quantity: Int
    
    init(ingredients: String, unit: UnitOfMeasure, quantity: Int) {
        self.ingredients = ingredients
        self.unit = unit
        self.quantity = quantity
    }
    

    
    enum UnitOfMeasure: String, Codable {
        case oz = "oz"
        case cup = "cup"
        case gallon = "gal"
        case teaspoon = "tsp"
        case tablespoon = "tbsp"
        case quart = "qt"
        case grams = "gm"
        case pint = "pt"
        case none = "N/A"
        case qty = "qty"
    }
    
}



