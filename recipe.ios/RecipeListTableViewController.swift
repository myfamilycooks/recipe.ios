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
    var recipeHeaders = [RecipeHeader]();
    var recipeService = RecipeNetworkService();
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show a spinner
        self.showSpinnerAndFreezeApplication();
        
        recipeService.getRecipeHeaders { (succeeded, message, recipeheaders) in
            
            if(!succeeded){
                
                // a error occured.
                self.showSimpleAlert(title: "Error", message: message);
                
                // remove the spinner, and start responding to UI events.
                self.stopSpinnerAndAllowAppToAcceptUIEvents();
            } else {
            
                OperationQueue.main.addOperation {
                    
                    // set the data
                    self.recipeHeaders = recipeheaders!;
                    
                    // force a table refresh.
                    self.tableView.reloadData();
                    
                    self.stopSpinnerAndAllowAppToAcceptUIEvents();
                    
                }
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    // fires when a user click's the '+' button
    @IBAction func addRecipeButtonClick(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add", message: "Add another recipe" , preferredStyle: .alert);
        
        // add's a text field
        alertController.addTextField { (testField) in
            
        }
        
        // Add the "Save" button
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (alertAction) in
            
            // since we just added the textbox, it should be there added the
            if let textBox = alertController.textFields?.first{
                
                // grab the text
                let newRecipeText = textBox.text!;
                
                // and add it to the collection
                self.recipes.append(newRecipeText);
               
                // tell the view controller the data has changed.
                self.tableView.reloadData();
               
                
            }
        }));
        
        // add the "cancel" button, note we aren't adding a handler, because we don't care to do anything if the click it.
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil));
        
        
        self.present(alertController, animated: true, completion: nil);
        
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
        return recipeHeaders.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // reuse the cell if possible.
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        
        // set the chevron and the title of the
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator;
        //cell.textLabel?.text = recipes[indexPath.row];
        cell.textLabel?.text = recipeHeaders[indexPath.row].name;
        
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
                viewController.recipeHeader = recipeHeaders[indexRowSelected];
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
