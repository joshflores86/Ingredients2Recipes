//
//  RecipeModel.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import Foundation
import UIKit

class RecipeModel: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var ingredient: [IngredientModel]
    var instructions: String
    var timeHours: Int16
    var timeMinute: Int16
    var favorite: Bool
    
    
    init( name: String, ingredient: [IngredientModel], instructions: String, timeHours: Int16, timeMinute: Int16, favorite: Bool) {
        self.name = name
        self.ingredient = ingredient
        self.instructions = instructions
        self.timeHours = timeHours
        self.timeMinute = timeMinute
        self.favorite = favorite
    }
    
}

struct IngredientEntry {
    var textField: UITextField
    var picker: UITextField
}
