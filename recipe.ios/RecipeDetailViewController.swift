//
//  RecipeDetailViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 9/29/16.
//  Copyright © 2016 My Family Cooks. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var Recipe:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Recipe;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
