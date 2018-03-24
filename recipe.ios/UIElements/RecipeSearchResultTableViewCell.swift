//
//  RecipeSearchResultTableViewCell.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/24/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeSearchResultTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setResult(recipeSearchResult: RecipeSearchResultResponse){
        
        self.descriptionLabel.text = recipeSearchResult.description
        self.titleLabel.text = recipeSearchResult.name
        
        // check for a
        if let imageUrl = recipeSearchResult.imageUrl{
            self.recipeImage.sd_setImage(with: URL(string: imageUrl), completed: { (image, error, cachetype, url) in
                // should this closure be deleted?
            })
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
