//
//  AccountCreationViewController.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/10/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import UIKit

class AccountCreationViewController: UIViewController {

    let accountService = AccountService();
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func signUpButtonClick(_ sender: Any) {
        if let error = self.isFormValid(){
            // handle form validation
            self.showSimpleAlert(title: "Not quite yet...", message: error)
        } else{
            
            // TODO: show spinner
            self.showSpinnerAndFreezeApplication(activityIndicator: self.activityIndicator)
            
            // save it the web api.
            let fullName = "\(self.firstNameTextField.text!) \(self.lastNameTextField.text!)"
            let login = self.userNameTextField.text!
            let email = self.emailTextField.text!
            let password = self.passwordTextField.text!
            
            
            self.accountService.createAccount(login: login, fullName: fullName, email: email, password: password, completed: { (success, errorMessage, account) in
                
                // hide spinner.
                self.stopSpinnerAndUnfreeze(activityIndicator: self.activityIndicator)
                
                if (!success){
                    
                    // notify the user.
                    self.showSimpleAlert(title: "Error", message: errorMessage)
                    
                } else{
                    
                    // show a model letting the user know they succeeded with an "ok" button.
                    var successModal = UIAlertController(title: "Success", message: "Your account was created", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okActionAlert = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                    successModal.addAction(okActionAlert);
                    self.present(successModal, animated: true, completion: nil)
                }
            })
        }
    }
    
    func isFormValid() -> String?{
        
        // check first name
        guard self.firstNameTextField.text != nil else {
            return "Please enter your first name."
        }
        
        // check last name
        guard self.lastNameTextField.text != nil else  {
            return "Please enter your last name."
        }
        
        // check user name
        guard self.userNameTextField.text != nil else {
            return "Please pick a user name."
        }
        
        // check email
        guard self.emailTextField.text != nil else {
            return "Please enter your email."
        }
        
        
        // check password
        guard self.passwordTextField.text != nil else {
            return "Please pick a password."
        }
        
        // check password
        guard self.passwordTextField.text == self.reEnterPasswordTextField.text else {
            return "Passwords must match."
        }
        
        // otherwise all passed validation.
        return nil
    }
    
    // event that fires when the cancel button is clicked.
    @IBAction func cancelButtonClick(_ sender: Any) {
        
        // dismiss this view controller.
        self.dismiss(animated: true, completion: nil)
    }
}
