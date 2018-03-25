//
//  RecipeDetailsViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/24/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var recipeId:String!
    var recipeUrl:String?
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
        self.descriptionLabel.text = recipe.description
        
    }
}
