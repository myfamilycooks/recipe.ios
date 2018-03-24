//
//  RecipeSearchResultResponse.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/24/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import Foundation

public struct RecipeSearchResultsResponse : Decodable{
    var skip:Int?
    
    var count:Int?
    
    var take:Int?
    
    var recipes:[RecipeSearchResultResponse]
}

public struct RecipeSearchResultResponse: Decodable{
    var id:String?;
    
    var name:String?
    
    var description:String?
    
    var url:String?
    
    var imageUrl: String?
}
