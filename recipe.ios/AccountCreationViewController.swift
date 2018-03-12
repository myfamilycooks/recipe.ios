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
                    
                    // determine what to do next.
                    var success = 34
                    // show a pop-up notification of success.
                   
                }
                
            })
        }
    }
    
    func isFormValid() -> String?{
        return nil;
    }
    
    // event that fires when the cancel button is clicked.
    @IBAction func cancelButtonClick(_ sender: Any) {
        
        // dismiss this view controller.
        self.dismiss(animated: true, completion: nil)
    }
}
