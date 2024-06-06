//
//  IngredientModel.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

class IngredientModel: Codable {
    
    var ingredients: String
    var unit: UnitOfMeasure
    var quantity: Int64
    
    init(ingredients: String, unit: UnitOfMeasure, quantity: Int64) {
        self.ingredients = ingredients
        self.unit = unit
        self.quantity = quantity
    }
        
    enum UnitOfMeasure: String, Codable {
        case oz = "oz"
        case cup = "cup"
        case gallon = "gal"
        case teaSpoon = "tsp"
        case tableSpoon = "tbsp"
        case quart = "qt"
        case grams = "gm"
        case pint = "pt"
        case none = "N/A"
        case qty = "qty"
    }
    
}


