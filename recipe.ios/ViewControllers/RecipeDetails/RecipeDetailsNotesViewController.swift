//
//  RecipeDetailsNoteslViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/25/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import UIKit

class RecipeDetailsNotesViewController: UIViewController,RecipeDetailsDescribable {
    
    var recipe: Recipe?{
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
