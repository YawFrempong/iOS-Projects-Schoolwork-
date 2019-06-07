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

    @IBOutlet weak var tableView: UITableView!
    
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?
    var db: Firestore?
    
    var forums = [String:Forum]()
    var forumKeys = [String]()
    var selectedDocumentID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "ForumTableViewCell", bundle: nil)
        
        tableView.register(cellNib, forCellReuseIdentifier: "forumCell")
        
        db = Firestore.firestore()
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.user = user
                
                self.db!.collection("forums").order(by: "timestamp", descending: true).addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        print("Error retreiving collection: \(error)")
                    } else {
                        let documents = querySnapshot?.documents
                        
                        for document in documents! {
                            
                            let data = document.data()
                            self.forums[document.documentID] = Forum(userID: data["userID"] as! String, likes: data["likes"] as! [String : Bool], message: data["message"] as! String, name: data["name"] as! String, timestamp: data["timestamp"] as! Timestamp)
                        }
                        
                        self.forumKeys.removeAll()
                        self.forumKeys.append(contentsOf: self.forums.keys)
                        self.tableView.reloadData()
                        
                        querySnapshot?.documentChanges.forEach({ diff in
                            let document = diff.document
                            let data = document.data()
                            
                            if (diff.type == .added || diff.type == .modified) {
                                self.forums[document.documentID] = Forum(userID: data["userID"] as! String, likes: data["likes"] as! [String : Bool], message: data["message"] as! String, name: data["name"] as! String, timestamp: data["timestamp"] as! Timestamp)
                            }
                            if (diff.type == .removed) {
                                self.forums.removeValue(forKey: document.documentID)
                            }
                            
                            self.forumKeys.removeAll()
                            self.forumKeys.append(contentsOf: self.forums.keys)
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
        //logout user in firebase first
        //then go to the login screen
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewForum" {
            let destination = segue.destination as! ForumDetailsViewController
            
            destination.forum = forums[selectedDocumentID!]
            destination.forumID = selectedDocumentID
        }
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forumCell", for: indexPath) as! ForumTableViewCell
        
        let documentID = forumKeys[indexPath.row]
        
        let forum = self.forums[documentID]!
        
        cell.nameLabel.text = forum.name
        cell.messageLabel.text = forum.message
        cell.likesLabel.text = "likes " + String(forum.likes.count)
        
        if user?.uid == forum.userID {
            cell.deleteBtn.isHidden = false
        } else {
            cell.deleteBtn.isHidden = true
        }
        
        if let like = forum.likes[(user?.uid)!], like == true {
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like_favorite"), for: .normal)
        } else {
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like_not_favorite"), for: .normal)
        }
        
        cell.forumID = documentID
        
        cell.delegate = self
        
        return cell
    }
}

extension ContactsViewController: ForumTableViewCellDelegate {
    func deleteForum(cell: ForumTableViewCell) {
        if let forumID = cell.forumID {
            db?.collection("forums").document(forumID).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    func selectForum(cell: ForumTableViewCell) {
        selectedDocumentID = cell.forumID
        
        performSegue(withIdentifier: "viewForum", sender: self)
    }
    
    func likeForum(cell: ForumTableViewCell) {
        let forum = self.forums[cell.forumID!]!
        
        if forum.likes[user!.uid] != true {
            forum.likes[user!.uid] = true
            db?.collection("forums").document(cell.forumID!).setData(["likes" : forum.likes], merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
}
