//
//  NewForumViewController.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 4/8/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class NewForumViewController: UIViewController {
    
    var db: Firestore?
    @IBOutlet weak var forumMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            if let message = forumMessage.text, message != "" {
                var ref: DocumentReference? = nil
                ref = db!.collection("forums").addDocument(data: [
                    "message" : message,
                    "userID" : user.uid,
                    "name" : user.displayName!,
                    "likes" : [String:Bool](),
                    "timestamp" : Timestamp(date: Date())
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
                let alert = UIAlertController(title: "Message Missing", message: "Message field is empty.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
