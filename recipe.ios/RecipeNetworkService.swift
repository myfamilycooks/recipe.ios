//
//  RecipeNetworkService.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 10/8/16.
//  Copyright © 2016 My Family Cooks. All rights reserved.
//

import Foundation
import UIKit;

public class RecipeNetworkService: NetworkService{
    
    var baseUrl:String
    
    override init() {
        self.baseUrl = Configuration.webUrl;
    }
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default;
        return URLSession(configuration: config);
    }();
    
    func getRecipe(recipeId:Int, getComplete:@escaping (_ succeeded:Bool, _ message: String, _ recipe:Recipe?)->()){
    
        let url = "\(self.baseUrl)/api/recipe/\(recipeId)";
        
        self.performNetworkCall(url: url, httpMethod: "GET", postParameters: nil) { (succeeded, message, jsonObject) in
            
            if(!succeeded){
                // error case
                getComplete(false, message, nil);
            } else{
                
                // try to deserialize the response
                do{
                    let json = try JSONSerialization.jsonObject(with: jsonObject!, options: []) as? AnyObject;
                    let recipe = self.convertJsonToRecipe(json: json!);
                    getComplete(true, "Success", recipe);
                } catch{
                    getComplete(false,"Unable to serialize: \(error)", nil);
                }
            }
        }
    }
    
    func getRecipeHeaders(getComplete:@escaping (_ succeeded:Bool, _ message:String, _ recipeHeaders:[RecipeHeader]?)->()){
        
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
    
    func getImage(imageUrl:String, completion: @escaping (UIImage) -> Void){
    
        let url = URL(string: imageUrl);
        let request = URLRequest(url: url!);
        //var session = URLSession
        let task = self.session.dataTask(with: request) { (data, response, error) in
            
            let result = self.processImageRequest(data: data, error: error);
            
            completion(result!);
        }
        
        task.resume();
        
    }
    
    private func processImageRequest(data: Data?, error: Error?)-> UIImage?{
        guard
            let imageData = data,
            let image = UIImage(data:imageData) else{
                // handle error
                return nil;
        }
        
        return image;
        
    }
    
    private func convertJsonToRecipe(json:AnyObject) -> Recipe?{
        guard
            let recipeId = json["recipeId"] as? Int,
            let name = json["name"] as? String,
            let description = json["description"] as? String,
            let imageUrl = json["imageUrl"] as? String else{
                
                // if the guard failed, then the json object was not in the shape we thought it was.
                return nil;
        
        }
        
        let recipe = Recipe(recipeId: recipeId, name: name, description: description, ImageUrl: imageUrl);
        
        return recipe;
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
        guard
            let recipeId = json["recipeId"] as? Int,
            let name = json["name"] as? String else{
        
                // if the guard failed, then the json object was not in the shape we thought it was.
                return nil;
        }
        
        let recipeHeader = RecipeHeader(recipeId: recipeId, name: name);
        
        
        return recipeHeader;
    }
    
}
