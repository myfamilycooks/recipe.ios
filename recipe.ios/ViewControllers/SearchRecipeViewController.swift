//
//  SearchRecipeViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/24/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import UIKit

class SearchRecipeViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchResults: RecipeSearchResultsResponse?
    let spinner:UIActivityIndicatorView = UIActivityIndicatorView()
    
    //var searchBar = UISearchBar()
    //@IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupSearchBar()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupSearchBar(){
        
        //self.searchController.delegate = self;
        
        // tells the system we are implementing the UISearchResultUpdating protocol
        self.searchController.searchResultsUpdater = self
        
        // determines this will obscure the view it is presented over.
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        // give a message what to do in the search.
        self.searchController.searchBar.placeholder = "Search Recipes"
        
        // adding the search controller to the nav
        self.navigationItem.searchController = self.searchController
        //self.navigationItem.titleView = self.searchController
        
        // ensure that the search bar does not remain on the screen if the user navigates to another view controller
        self.definesPresentationContext = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "selectRecipe"){
            if let recipeDetails = segue.destination as? RecipeDetailsViewController{
                
                if let selectedTableIndex = self.searchResultsTable.indexPathForSelectedRow   {
                    
                    if let selectedRecipe = self.searchResults?.recipes[selectedTableIndex.row]{
                        recipeDetails.recipeId = selectedRecipe.id
                        recipeDetails.recipeUrl = selectedRecipe.imageUrl
                    }
                }
            }
        }
    }
}

extension SearchRecipeViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        let foo = "foo"
    }
}

extension SearchRecipeViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // actual search tap
        if let searchTerm = searchBar.text{
            
            self.showSpinner(activityIndicator: self.spinner)
            
            // call the http endpoint
            SearchService.performSearch(searchText: searchTerm) { (success, errorMessage, result) in
                
                self.stopSpinner(activityIndicatory: self.spinner)
                
                if(success){
                    // collect the results and reload the grid
                    self.searchResults = result
                    self.searchResultsTable.reloadData()
                } else {
                    self.showSimpleAlert(title: "error", message: errorMessage)
                }
            }
        }
    }
}

extension SearchRecipeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.searchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let searchResultForIndex = self.searchResults?.recipes[indexPath.row]{
            
            if let searchCell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as? RecipeSearchResultTableViewCell{
                searchCell.setResult(recipeSearchResult: searchResultForIndex)
                return searchCell
            }
        }
        
        return UITableViewCell();
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // hard coded for now, this can be updated later.
        return 100
    }
}


