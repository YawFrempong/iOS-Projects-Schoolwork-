//
//  ContactsViewController.swift
//  InClass09
//
//  Created by Shehab, Mohamed on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ContactsViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    var user: User?
    var db: Firestore?
    var contacts = [String:Contact]()
    var contactKeys = [String]()
    var selectedDocumentID: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "ContactTableViewCell", bundle: nil)
        
        tableView.register(cellNib, forCellReuseIdentifier: "Contact")
        
        
        db = Firestore.firestore()

        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.user = user
                
                self.db!.collection((self.user?.uid)!).addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        print("Error retreiving collection: \(error)")
                    } else {
                        let documents = querySnapshot?.documents
                        
                        for document in documents! {
                            
                            let data = document.data()
                            self.contacts[document.documentID] = Contact(name: data["name"] as! String, email: data["email"] as! String, phone: data["phone"] as! String, phoneType: data["phoneType"] as! String)
                        }
                        
                        self.contactKeys.removeAll()
                        self.contactKeys.append(contentsOf: self.contacts.keys)
                        self.tableView.reloadData()
                        
                        querySnapshot?.documentChanges.forEach({ diff in
                            let document = diff.document
                            let data = document.data()
                            
                            if (diff.type == .added || diff.type == .modified) {
                                self.contacts[document.documentID] = Contact(name: data["name"] as! String, email: data["email"] as! String, phone: data["phone"] as! String, phoneType: data["phoneType"] as! String)
                            }
                            if (diff.type == .removed) {
                                self.contacts.removeValue(forKey: document.documentID)
                            }
                            
                            self.contactKeys.removeAll()
                            self.contactKeys.append(contentsOf: self.contacts.keys)
                            self.tableView.reloadData()
                        })
                    }
                }
            } else {
                AppDelegate.showLogin()
            }
        }
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewDetails" {
            let destination = segue.destination as! DetailsViewController
            
            destination.contactDocumentID = selectedDocumentID
        }
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath) as! ContactTableViewCell
        
        let documentID = contactKeys[indexPath.row]
        
        let contact = self.contacts[documentID]!
        
        cell.nameLabel.text = contact.name
        cell.emailLabel.text = contact.email
        cell.phoneLabel.text = contact.phone + " (" + contact.phoneType + ")"
        cell.delegate = self
        cell.documentID = documentID
        
        return cell
    }
}

extension ContactsViewController: ContactTableViewCellDelegate {
    func selectContact(cell: ContactTableViewCell) {
        selectedDocumentID = cell.documentID
        
        performSegue(withIdentifier: "viewDetails", sender: self)
    }
    
    func deleteContact(cell: ContactTableViewCell) {
        db!.collection((user?.uid)!).document(cell.documentID!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
