//
//  RecipeDetailsStepsViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/25/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import UIKit

class RecipeDetailsStepsViewController: UIViewController, RecipeDetailsDescribable {
    

    @IBOutlet weak var stepsViewTable: UITableView!
    
    var recipe: Recipe?{
        didSet{
            if self.stepsViewTable != nil{
                self.stepsViewTable.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
   
}

extension RecipeDetailsStepsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipe?.steps?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell"){
            
            if let steps = self.recipe?.steps{
                
                let orderedSteps = steps.sorted(by: { (a, b) -> Bool in
                    if let ordinalA = a.ordinal{
                        if let ordinalB = b.ordinal{
                            return ordinalA < ordinalB
                        }
                    }
                    
                    // TODO: what do if we don't have a value???
                    return false
                })
                
                if let instruction = orderedSteps[indexPath.row].instructions{
                    cell.textLabel?.text = "\(indexPath.row) \(instruction)"
                }
            }
            
            return cell
        } else{
            return UITableViewCell()
        }
    }
}
