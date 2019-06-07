//
//  SignUpViewController.swift
//  InClass09
//
//  Created by Shehab, Mohamed on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        //sign up the new user using Firebase
        //when done successfully
        //go to the Contacts View Controller.
        
        if let email = emailTextField.text, let password = passwordTextField.text, let confirmPass = confirmPasswordTextField.text, email != "" && password != "", password == confirmPass {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "Sign up unsuccessful with the provided data.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    AppDelegate.showContacts()
                }
            }
        } else {
            let alert = UIAlertController(title: "Invalid Input", message: "Either a field is empty or the passwords do not match.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        AppDelegate.showLogin()
    }
    
}
