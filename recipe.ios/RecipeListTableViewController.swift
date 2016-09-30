//
//  RecipeListTableViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 9/29/16.
//  Copyright © 2016 My Family Cooks. All rights reserved.
//

import UIKit

class RecipeListTableViewController: UITableViewController {
    
    // hard coding data source for now. This should come from a Network data service.
    var recipes = ["Pizza", "Pork chops", "Cookies", "Chicken Parm", "Alaska Salmon Bake with Pecan Crunch Coating"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Hard coding to just 1 section, until we need more.
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // reuse the cell if possible.
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        
        // set the chevron and the title of the
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator;
        cell.textLabel?.text = recipes[indexPath.row];
        
        return cell;
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // figure out which ViewController we are segueing to...
        if segue.identifier == "ShowRecipe"{
            
            // get the row index of the recipe the user selected.
            let indexRowSelected = self.tableView.indexPathForSelectedRow!.row
            
            // see if we can cast the destination View controller to the RecipeDetailView Controller
            if let viewController = segue.destination as? RecipeDetailViewController {
                
                // pass the recipe to the next view controller.
                viewController.Recipe = recipes[indexRowSelected];
            }
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
}