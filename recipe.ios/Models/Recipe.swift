//
//  Recipe.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/24/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import Foundation

public struct Recipe : Decodable{
    var title:String?
    
    var key:String?
    
    var tags:String?
    
    var description:String?
    
    var notes:String?
    
    var ingredients:[RecipeIngredient]?
    
    var steps:[Step]?
    
    var id:String?
    
    var createdBy:String?
    
    var modifiedBy:String?
}

public struct RecipeIngredient : Decodable{
   // var ordinal:Int?
    
    //var recipeId:String?
    
    //var qunatity:Double?
    
   // var units:String?
    
    var ingredient:String?
    
    //var notes:String?
    
    //var id:String?
    
    //var createdBy:String?
    
    //var modifiedby:String?
}

public struct Step: Decodable {
    var ordinal:Int?
    
    var recipeId:String?
    
    var instructions:String?
    
    var id:String?
    
    var createdBy:String?
    
    var modifiedby:String?
    
}
