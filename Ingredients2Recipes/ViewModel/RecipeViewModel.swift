//
//  RecipeViewModel.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import Foundation
import CoreData


class RecipeViewModel: Observable {
    
    @Published var inHouseRecipe: [RecipeModel] = [
        RecipeModel(name: "Pancakes",
                    ingredient: [
                        IngredientModel(ingredients: "All Purpose Flour", unit: .cup, quantity: 1),
                        IngredientModel(ingredients: "Sugar", unit: .tableSpoon, quantity: 2),
                        IngredientModel(ingredients: "Baking Powder", unit: .teaSpoon, quantity: 2),
                        IngredientModel(ingredients: "Salt", unit: .teaSpoon, quantity: 0.5),
                        IngredientModel(ingredients: "Milk", unit: .cup, quantity: 1),
                        IngredientModel(ingredients: "Unsalted butter, melted, or vegetable oil", unit: .tableSpoon, quantity: 2),
                        IngredientModel(ingredients: "Egg", unit: .none, quantity: 1),
                        
                    ],
                    instructions: "Preheat oven to 200 degrees. Have a baking sheet or heatproof platter ready to keep cooked pancakes warm in the oven. \n\n In a small bowl, whisk together flour, sugar, baking powder, and salt; set aside.\n\n In a medium bowl, whisk together milk, butter (or oil), and egg. Add dry ingredients to milk mixture; whisk until just moistened (Do not overmix; a few small lumps are fine).\n\n Heat a large skillet (nonstick or cast-iron) or griddle over medium.\n\n Fold a sheet of paper towel in half, and moisten with oil; carefully rub skillet with oiled paper towel.\n\n For each pancake, spoon 2 to 3 tablespoons of batter onto skillet, using the back of the spoon to spread batter into a round skillet (you should be able to fit 2 to 3 in a large skillet).\n\n Cook until surface of pancakes have some bubbles and a few have burst, 1 to 2 minutes. Flip carefully with a thin spatula, and cook until browned on the underside, 1 to 2 minutes more.\n\n Transfer to a baking sheet or platter; cover loosely with aluminum foil, and keep warm in oven.\n\n Continue with more oil and remaining batter. (You'll have 12 to 15 pancakes.) Serve warm, with desired toppings. ",
                    timeHours: 1, timeMinute: 00, favorite: false ),
        
        RecipeModel(name: "Fluffy Pancakes",
                    ingredient: [
                        IngredientModel(ingredients: "All Purpose Flour", unit: .cup, quantity: 1),
                        IngredientModel(ingredients: "Sugar", unit: .tableSpoon, quantity: 2),
                        IngredientModel(ingredients: "Baking Powder", unit: .teaSpoon, quantity: 2),
                        IngredientModel(ingredients: "Salt", unit: .teaSpoon, quantity: 0.5),
                        IngredientModel(ingredients: "Milk", unit: .cup, quantity: 1),
                        IngredientModel(ingredients: "Unsalted butter, melted, or vegetable oil", unit: .tableSpoon, quantity: 2),
                        IngredientModel(ingredients: "Egg", unit: .none, quantity: 1),
                        
                    ],
                    instructions: " 1. Preheat oven to 200 degrees. Have a baking sheet or heatproof platter ready to keep cooked pancakes warm in the oven.\n\n 2. In a small bowl, whisk together flour, sugar, baking powder, and salt; set aside.\n\n 3. In a medium bowl, whisk together milk, butter (or oil), and egg. Add dry ingredients to milk mixture; whisk until just moistened (Do not overmix; a few small lumps are fine).\n\n 4. Heat a large skillet (nonstick or cast-iron) or griddle over medium.\n\n 5. Fold a sheet of paper towel in half, and moisten with oil; carefully rub skillet with oiled paper towel.\n\n 6. For each pancake, spoon 2 to 3 tablespoons of batter onto skillet, using the back of the spoon to spread batter into a round skillet (you should be able to fit 2 to 3 in a large skillet).\n\n 7. Cook until surface of pancakes have some bubbles and a few have burst, 1 to 2 minutes. Flip carefully with a thin spatula, and cook until browned on the underside, 1 to 2 minutes more.\n\n 8. Transfer to a baking sheet or platter; cover loosely with aluminum foil, and keep warm in oven.\n\n Continue with more oil and remaining batter. (You'll have 12 to 15 pancakes.) Serve warm, with desired toppings.",
                    timeHours: 1, timeMinute: 00, favorite: false),
        RecipeModel(name: "Thin Pancakes",
                    ingredient: [
                        IngredientModel(ingredients: "All Purpose Flour", unit: .cup, quantity: 1),
                        IngredientModel(ingredients: "Sugar", unit: .tableSpoon, quantity: 2),
                        IngredientModel(ingredients: "Baking Powder", unit: .teaSpoon, quantity: 2),
                        IngredientModel(ingredients: "Salt", unit: .teaSpoon, quantity: 0.5),
                        IngredientModel(ingredients: "Milk", unit: .cup, quantity: 1),
                        IngredientModel(ingredients: "Unsalted butter, melted, or vegetable oil", unit: .tableSpoon, quantity: 2),
                        IngredientModel(ingredients: "Egg", unit: .none, quantity: 1),
                        
                    ],
                    instructions: " Preheat oven to 200 degrees. Have a baking sheet or heatproof platter ready to keep cooked pancakes warm in the oven. \n\nIn a small bowl, whisk together flour, sugar, baking powder, and salt; set aside.\n\nIn a medium bowl, whisk together milk, butter (or oil), and egg. Add dry ingredients to milk mixture; whisk until just moistened (Do not overmix; a few small lumps are fine).\n\nHeat a large skillet (nonstick or cast-iron) or griddle over medium.\n\nFold a sheet of paper towel in half, and moisten with oil; carefully rub skillet with oiled paper towel.\n\nFor each pancake, spoon 2 to 3 tablespoons of batter onto skillet, using the back of the spoon to spread batter into a round skillet (you should be able to fit 2 to 3 in a large skillet).\n\nCook until surface of pancakes have some bubbles and a few have burst, 1 to 2 minutes. Flip carefully with a thin spatula, and cook until browned on the underside, 1 to 2 minutes more.\n\nTransfer to a baking sheet or platter; cover loosely with aluminum foil, and keep warm in oven.\n\nContinue with more oil and remaining batter. (You'll have 12 to 15 pancakes.) Serve warm, with desired toppings. ",
                    timeHours: 1,
                    timeMinute: 00,
                    favorite: false),
        RecipeModel(name: "Sexy Pancakes",
                    ingredient: [
                        IngredientModel(ingredients: "All Purpose Flour", unit: .cup, quantity: 1),
                        IngredientModel(ingredients: "Sugar", unit: .tableSpoon, quantity: 2),
                        IngredientModel(ingredients: "Baking Powder", unit: .teaSpoon, quantity: 2),
                        IngredientModel(ingredients: "Salt", unit: .teaSpoon, quantity: 0.5),
                        IngredientModel(ingredients: "Milk", unit: .cup, quantity: 1),
                        IngredientModel(ingredients: "Unsalted butter, melted, or vegetable oil", unit: .tableSpoon, quantity: 2),
                        IngredientModel(ingredients: "Egg", unit: .none, quantity: 1),
                        
                    ],
                    instructions: "Preheat oven to 200 degrees. Have a baking sheet or heatproof platter ready to keep cooked pancakes warm in the oven. In a small bowl, whisk together flour, sugar, baking powder, and salt; set aside. In a medium bowl, whisk together milk, butter (or oil), and egg. Add dry ingredients to milk mixture; whisk until just moistened (Do not overmix; a few small lumps are fine). Heat a large skillet (nonstick or cast-iron) or griddle over medium. Fold a sheet of paper towel in half, and moisten with oil; carefully rub skillet with oiled paper towel. For each pancake, spoon 2 to 3 tablespoons of batter onto skillet, using the back of the spoon to spread batter into a round (you should be able to fit 2 to 3 in a large skillet). Cook until surface of pancakes have some bubbles and a few have burst, 1 to 2 minutes. Flip carefully with a thin spatula, and cook until browned on the underside, 1 to 2 minutes more. Transfer to a baking sheet or platter; cover loosely with aluminum foil, and keep warm in oven. Continue with more oil and remaining batter. (You'll have 12 to 15 pancakes.) Serve warm, with desired toppings. ",
                    timeHours: 1,
                    timeMinute: 00, favorite: false)
        
    ]
    
    let coreDataStack = AppDelegate.shared
    
    func saveRecipe(_ recipe: RecipeModel) {
        let managedObjectContext = coreDataStack.viewContext
        
        let newRecipe = RecipeEntity(context: managedObjectContext)
        
        newRecipe.name = recipe.name
        newRecipe.instructions = recipe.instructions
        newRecipe.hours = recipe.timeHours
        newRecipe.minute = recipe.timeMinute
        newRecipe.favorite = recipe.favorite
        
        let ingredientsSet = NSMutableSet()
        for ingredient in recipe.ingredient {
            let ingredientEntity = IngredientEntity(context: managedObjectContext)
            ingredientEntity.ingredient = ingredient.ingredients
            ingredientEntity.unit = ingredient.unit.rawValue
            ingredientEntity.quantity = ingredient.quantity
            ingredientsSet.add(ingredientEntity)
        }
        newRecipe.ingredients = ingredientsSet
        coreDataStack.saveContext()
    }
    
    func fetchRequest() -> [RecipeModel] {
        let managedContext = coreDataStack.viewContext
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        do {
            let recipeEntity = try managedContext.fetch(fetchRequest)
            var recipeModel: [RecipeModel] = []
            
            for recipe in recipeEntity {
                var ingredientModel: [IngredientModel] = []
                if let ingredientEntities = recipe.ingredients?.allObjects as? [IngredientEntity]{
                    for ingredients in ingredientEntities {
                        let ingredientsModel = IngredientModel(
                            ingredients: ingredients.ingredient ?? "",
                            unit: IngredientModel.UnitOfMeasure(rawValue: ingredients.unit ?? "") ?? .none,
                            quantity: ingredients.quantity)
                        ingredientModel.append(ingredientsModel)
                    }
                }
                let recipeModels = RecipeModel(
                    name: recipe.name ?? "",
                    ingredient: ingredientModel,
                    instructions: recipe.instructions ?? "",
                    timeHours: recipe.hours,
                    timeMinute: recipe.minute,
                    favorite: recipe.favorite)
                recipeModel.append(recipeModels)
            }
            return recipeModel
        }catch let error as NSError{
            print("Error fetching: \(error), \(error.userInfo)")
            return []
        }
        
    }
    
    
    
}

