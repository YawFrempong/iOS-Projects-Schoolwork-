//
//  LoginViewController.swift
//  InClass09
//
//  Created by Shehab, Mohamed on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                Auth.auth().removeStateDidChangeListener(self.handle!)
                AppDelegate.showContacts()
            }
        }
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        //login using Firebase
        //when done successfully
        //go to the Contacts View Controller.
        if let email = emailTextField.text, let password = passwordTextField.text, email != "" && password != "" {
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "Incorrect email or password.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Field Missing", message: "One or more fields is empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        AppDelegate.showSignUp()
    }
}
