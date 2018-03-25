//
//  RecipeDetailsViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/24/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import UIKit

class RecipeDetailsTabViewController: UITabBarController {
    
    var recipeId:String!
    var recipeImageUrl:String?
    let spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadRecipe()
    }
    
    func loadRecipe(){
        
        self.showSpinner(activityIndicator: self.spinner)
        
        RecipeService.getRecipe(recipeId: self.recipeId) { (success, errorMessage, recipe) in
            self.stopSpinner(activityIndicatory: self.spinner)
            
            if(success){
                
                if let recipe = recipe{
                    self.bindRecipeToView(recipe: recipe)
                }
                
            } else {
                self.showSimpleAlert(title: "Error", message: errorMessage)
            }
        }
    }
    
    func bindRecipeToView(recipe:Recipe){
        self.title = recipe.title
        
        // pass the recipe down to the children
        if let childViewControllers = self.viewControllers{
     
            for childViewController in childViewControllers{
             
                // optional send the pic to the general vc
                if var recipeDetailsGeneralViewController = childViewController as? RecipeDetailsGeneralViewController{
                    recipeDetailsGeneralViewController.recipeImageUrl = self.recipeImageUrl
                }
                
                if var detailsDescribable = childViewController as? RecipeDetailsDescribable{
                    detailsDescribable.recipe = recipe
                }
            }
        }
    }
}
