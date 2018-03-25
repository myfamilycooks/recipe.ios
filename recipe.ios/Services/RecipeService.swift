//
//  RecipeService.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/24/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import Foundation
import Alamofire

public struct RecipeService{
    
    
    public static func getRecipe(recipeId:String, completed:@escaping(_ succedded:Bool, _ errorMessage: String?, _ recipe: Recipe?)->()){
        
        // verify this.
        let url = "\(Configuration.webUrl)/api/recipe/\(recipeId)"
        let headers = SecurityService.getHeaders()
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
        .validate(statusCode: 200...200)
            .responseJSON { (response) in
                switch response.result{
                    
                case .success(let val):
                    do{
                        let recipe = try JSONDecoder().decode(Recipe.self, from: response.data!)
                        completed(true, nil, recipe)
                    } catch(let serializationError){
                        completed(false, "Serialization error: \(serializationError.localizedDescription)", nil)
                        
                    }
                case .failure(let error):
                    // see if we can parse the custom error
                    if let bistroError = HttpErrorParser.parse(data: response.data){
                        completed(false, bistroError.description, nil)
                    }
                    
                    completed(false, error.localizedDescription, nil)
                }
        }
    }
}
