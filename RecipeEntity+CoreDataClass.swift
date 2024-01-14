//
//  RecipeEntity+CoreDataClass.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//
//

//import Foundation
//import CoreData
//
//
//public class RecipeEntity: NSManagedObject, Identifiable {
//    
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
//        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
//    }
//
//    @NSManaged public var name: String
//    @NSManaged public var instructions: String
//    @NSManaged public var hours: Int16
//    @NSManaged public var minute: Int16
//    @NSManaged public var favorite: Bool
//    @NSManaged public var ingredients: NSSet
//
//    @objc(addIngredientsObject:)
//    @NSManaged public func addToIngredients(_ value: IngredientEntity)
//
//    @objc(removeIngredientsObject:)
//    @NSManaged public func removeFromIngredients(_ value: IngredientEntity)
//
//    @objc(addIngredients:)
//    @NSManaged public func addToIngredients(_ values: NSSet)
//
//    @objc(removeIngredients:)
//    @NSManaged public func removeFromIngredients(_ values: NSSet)
//
//
//}
