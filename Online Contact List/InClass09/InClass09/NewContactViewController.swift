//
//  NewContactViewController.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class NewContactViewController: UIViewController {

    var db: Firestore?
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var phoneTypeSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
    }
    
    @IBAction func addUser(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            if let name = nameLabel.text, let email = emailLabel.text, let phone = phoneLabel.text, let phoneType = phoneTypeSegment.titleForSegment(at: phoneTypeSegment.selectedSegmentIndex), name != "" && email != "" && phone != "" {
                var ref: DocumentReference? = nil
                ref = db!.collection(user.uid).addDocument(data: [
                    "name" : name,
                    "email" : email,
                    "phone" : phone,
                    "phoneType" : phoneType
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                let alert = UIAlertController(title: "Field Missing", message: "One or more fields is empty.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
