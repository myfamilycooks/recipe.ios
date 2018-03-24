//
//  UIViewControllerExtensions.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/10/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showSimpleAlert(title:String?, message:String?){
        
        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert);
        
        // add a dismiss action.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            // just dismiss the alert
            alert.dismiss(animated: true, completion: nil);
        }))
        
        // finally show the alert to the user.
        self.present(alert, animated: true, completion: nil);
    }
    
    func showSpinnerAndFreezeApplication(activityIndicator:UIActivityIndicatorView){
        self.showSpinner(activityIndicator: activityIndicator)
        
        // stop the applicaiton from accepting touch events.
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopSpinnerAndUnfreeze(activityIndicator:UIActivityIndicatorView){
        self.stopSpinner(activityIndicatory: activityIndicator)
        
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func showSpinner(activityIndicator:UIActivityIndicatorView){
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = self.view.center
        
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
    }
    
    func stopSpinner(activityIndicatory: UIActivityIndicatorView){
        activityIndicatory.stopAnimating()
    }
    
}


