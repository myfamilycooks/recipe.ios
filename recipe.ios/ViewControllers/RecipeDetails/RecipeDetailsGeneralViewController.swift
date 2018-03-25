//
//  RecipeDetailsGeneralViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/25/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeDetailsGeneralViewController: UIViewController,RecipeDetailsDescribable {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var recipeImageUrl: String?
    var recipe: Recipe?{
        didSet{
            if let recipe = recipe{
                self.bind(recipe: recipe)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func bind(recipe:Recipe){
        self.titleLabel.text = recipe.title
        
        if let imageUrl = self.recipeImageUrl{
            self.recipeImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        
        if let ingredients = recipe.ingredients {
            
            self.ingredientsLabel.text = ingredients.reduce("", { (result, ingredient) in
                
                if let ingrediantText = ingredient.ingredient{
                    
                    if result == ""{
                        // first iteration
                        return ingrediantText
                    } else{
                        // additional iterations
                        return "\(result ?? ""), \(ingrediantText)"
                    }
                }
                return result
            })
        }
        
        self.descriptionLabel.text = recipe.description
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
