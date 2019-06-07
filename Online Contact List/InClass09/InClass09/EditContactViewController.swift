//
//  EditContactViewController.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class EditContactViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var phoneTypeSegment: UISegmentedControl!
    
    var db: Firestore?
    var contactDocumentID: String?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        if let usr = Auth.auth().currentUser {
            user = usr
            db!.collection(user!.uid).document(contactDocumentID!).addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                
                self.nameField.text = data["name"] as? String
                self.emailField.text = data["email"] as? String
                self.phoneField.text = data["phone"] as? String
                
                let index = ["Cell":0,"Home":1,"Office":2]
                
                self.phoneTypeSegment.selectedSegmentIndex = index[(data["phoneType"] as? String)!]!
            }
        }
    }

    @IBAction func updateBtn(_ sender: Any) {
        if let name = nameField.text, let email = emailField.text, let phone = phoneField.text, let phoneType = phoneTypeSegment.titleForSegment(at: phoneTypeSegment.selectedSegmentIndex), name != "" && email != "" && phone != "" {
            db!.collection((user?.uid)!).document(contactDocumentID!).setData([
                "name": name,
                "email": email,
                "phone": phone,
                "phoneType": phoneType
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
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
