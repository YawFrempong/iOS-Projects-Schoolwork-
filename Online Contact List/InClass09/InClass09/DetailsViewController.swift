//
//  DetailsViewController.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class DetailsViewController: UIViewController {

    var db: Firestore?
    var contactDocumentID: String?
    var user: User?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTypeLabel: UILabel!
    
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
                
                self.nameLabel.text = data["name"] as? String
                self.emailLabel.text = data["email"] as? String
                self.phoneLabel.text = data["phone"] as? String
                self.phoneTypeLabel.text = data["phoneType"] as? String
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact" {
            let destination = segue.destination as! EditContactViewController
            
            destination.contactDocumentID = contactDocumentID
        }
    }

    @IBAction func deleteBtn(_ sender: Any) {
        db!.collection((user?.uid)!).document(contactDocumentID!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
