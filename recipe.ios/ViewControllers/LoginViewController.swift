//
//  LoginViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/10/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let tokenService = TokenService()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonClick(_ sender: Any) {
        
        if let validationError = self.IsValid(){
            self.showSimpleAlert(title: "Error", message: validationError)
        }else{
            
            if let userName = self.userNameTextField.text,
                let password = self.passwordTextField.text{
                
                // show a spinner.
                self.showSpinner(activityIndicator: self.spinner)
                
                // make a call to the http endpoint.
                self.tokenService.getToken(userName: userName, password: password, completed: { (success, errorMessage, tokenResponse) in
                    
                    if(success){
                        // I assume we need to save this token in userDefaults?
                        // where to go from here??
                        // segue to next Viewcontroller?
                        //self.showSimpleAlert(title: "Token Received", message: tokenResponse!.token)
                        
                        // the user is loggedIn, so
                        self.performSegue(withIdentifier: "loggedIn", sender: self)
                    } else {
                        
                        self.showSimpleAlert(title: "Error", message: errorMessage)
                    }
                    
                     self.stopSpinner(activityIndicatory: self.spinner)
                })
            }
        }
    }
    
    
    func IsValid() -> String?{
        
        guard self.userNameTextField.text != nil else {
            return "Enter user name."
        }
        
        guard self.passwordTextField.text != nil else {
            return "Enter password."
        }
        
        return nil
    }
}
