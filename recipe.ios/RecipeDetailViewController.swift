//
//  RecipeDetailViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 9/29/16.
//  Copyright © 2016 My Family Cooks. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    
    var recipeHeader:RecipeHeader!;
    var recipe:Recipe!
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView();
    var recipeService = RecipeNetworkService();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = recipeHeader.name;
        
        self.recipeService.getRecipe(recipeId: recipeHeader.recipeId) { (succeeded, message, recipe) in
            
            if(!succeeded){
                // a error occured.
                self.showSimpleAlert(title: "Error", message: message);
                
                // remove this spinner, and start responding to UI Events.
                self.stopSpinnerAndAllowAppToAcceptUIEvents();
            } else {
            
                OperationQueue.main.addOperation {
                    
                    // set the data
                    self.recipeDescriptionTextView.text = recipe?.description;
                    
                    //let imageData = Data(
                    self.recipeService.getImage(imageUrl: recipe!.ImageUrl, completion: { (image) in
                        self.recipeImageView.image = image
                    })
                    
                    self.stopSpinnerAndAllowAppToAcceptUIEvents();
                }
            }
        }
    }
    
    func showSimpleAlert(title:String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        // add a dismiss action.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            // just dismiss the alert
            alert.dismiss(animated: true, completion: nil);
        }))
        
        // finally show the alert to the user.
        self.present(alert, animated: true, completion: nil);
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSpinnerAndFreezeApplication(){
        
        self.activityIndicator = UIActivityIndicatorView(frame: self.view.frame);
        self.activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5);
        self.activityIndicator.center = self.view.center;
        self.activityIndicator.hidesWhenStopped = true;
        self.activityIndicator.activityIndicatorViewStyle = .gray;
        self.view.addSubview(self.activityIndicator);
        self.activityIndicator.startAnimating();
        
        // stop the application from accepting touch events.
        UIApplication.shared.beginIgnoringInteractionEvents();
        
    }
    
    func stopSpinnerAndAllowAppToAcceptUIEvents(){
        
        self.stopSpinner();
        UIApplication.shared.endIgnoringInteractionEvents();
    }
    
    func stopSpinner(){
        self.activityIndicator.stopAnimating();
    }
    
}
