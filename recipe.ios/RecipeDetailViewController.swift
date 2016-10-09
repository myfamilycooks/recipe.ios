//
//  RecipeDetailViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 9/29/16.
//  Copyright © 2016 My Family Cooks. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipeHeader:RecipeHeader!;
    var recipe:Recipe!
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView();
    var recipeService = RecipeNetworkService();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = recipeHeader.name;
        
        //self.recipeService.
        
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
