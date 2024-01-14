//
//  IngredientModel.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import Foundation

class IngredientModel/*: NSObject, NSCoding, NSSecureCoding*/ {
    
    
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var ingredients: String
    var unit: UnitOfMeasure
    var quantity: Double
    
    init(ingredients: String, unit: UnitOfMeasure, quantity: Double) {
        self.ingredients = ingredients
        self.unit = unit
        self.quantity = quantity
    }
    
//    required init(coder aDecoder: NSCoder) {
//        self.ingredient = aDecoder.decodeObject(forKey: "ingredient")
//        self.unit = UnitOfMeasure(rawValue: aDecoder)
//    }
//    
//    func encode(with coder: NSCoder) {
//        coder.encode(ingredient, forKey: "ingredient")
//        coder.encode(unit, forKey: "unit")
//        coder.encode(quantity, forKey: "quantity")
//    }
    
    enum UnitOfMeasure: String {
        case oz = "oz"
        case cup = "cup"
        case gallon = "gal"
        case teaSpoon = "tsp"
        case tableSpoon = "tbsp"
        case quart = "qt"
        case grams = "gm"
        case pint = "pt"
        case none = "N/A"
    }
    
}


