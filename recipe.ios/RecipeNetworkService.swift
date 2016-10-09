//
//  RecipeNetworkService.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 10/8/16.
//  Copyright © 2016 My Family Cooks. All rights reserved.
//

import Foundation

public class RecipeNetworkService: NetworkService{
    
    var baseUrl:String
    
    override init() {
        self.baseUrl = Configuration.getWebUrl();
    }
    
    func getRecipeHeaders(getComplete:@escaping (_ succeeded:Bool, _ message:String, _ posts:[RecipeHeader]?)->()){
        
        let url = "\(self.baseUrl)/api/recipeheader";
        
        self.performNetworkCall(url: url, httpMethod: "GET", postParameters: nil) { (succeeded, message, jsonObject) in
            
            if(!succeeded){
                
                // error case
                getComplete(false, message, nil);
                
            } else{
                
                // try to deserialize the response.
                do{
                    let json = try JSONSerialization.jsonObject(with: jsonObject!, options: []) as? AnyObject;
                    let recipeHeaders = self.convertJsonToRecipeHeaders(json: json!);
                    getComplete(true, "Success", recipeHeaders);
                    
                } catch{
                    getComplete(false,"unable to serialize: \(error)", nil);
                }
                
            }
            
        }
        
    }
    
    private func convertJsonToRecipeHeaders(json:AnyObject) -> [RecipeHeader]{
        
        var recipeHeaders = [RecipeHeader]();
        
        for anItem in json as! [AnyObject]{
            if let recipeHeader = self.convertJsonToRecipeHeader(json: anItem){
                recipeHeaders.append(recipeHeader);
            }
        }
        
        return recipeHeaders;
    }
    
    private func convertJsonToRecipeHeader(json:AnyObject) -> RecipeHeader?{
        guard let
            recipeId = json["recipeId"] as? Int,
            let name = json["name"] as? String else{
        
                // if the guard failed, then the json object was not in the shape we thought it was.
                return nil;
        }
        
        let recipeHeader = RecipeHeader(recipeId: recipeId, name: name);
        
        
        return recipeHeader;
    }
    
}
