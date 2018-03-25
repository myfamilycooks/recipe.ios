//
//  SearchService.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/24/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import Foundation
import Alamofire

public struct SearchService{
    
    public static func performSearch(searchText:String, completed:@escaping(_ suceeded:Bool, _ errorMessage:String?, _ searchReslt:RecipeSearchResultsResponse?)->()){
    
        let url = "\(Configuration.webUrl)/api/search/recipes"
        
        var postDictionary = [String:Any]();
        postDictionary["searchText"] = searchText
        let headers = SecurityService.getHeaders()
        
        
        Alamofire.request(url, method: .post, parameters: postDictionary, encoding: JSONEncoding.default, headers: headers)
        .validate(statusCode: 200...200)
            .responseJSON { (responseData) in
                switch responseData.result{
                    
                case .success(let val):
                    do{
                        let recipeSearchResult = try JSONDecoder().decode(RecipeSearchResultsResponse.self, from: responseData.data!)
                        completed(true, nil, recipeSearchResult)
                        
                    } catch(let serializationError){
                        completed(false,"Serialization error: \(serializationError.localizedDescription)", nil)
                    }
                    
                case .failure(let error):
                    
                    // see if we can parse the custom error
                    if let bistroError = HttpErrorParser.parse(data: responseData.data){
                        completed(false, bistroError.description, nil)
                    }
                    
                    completed(false, error.localizedDescription, nil)
                }
        }
    }
}
