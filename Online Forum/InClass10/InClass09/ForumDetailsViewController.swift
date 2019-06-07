//
//  ForumDetailsViewController.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 4/8/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ForumDetailsViewController: UIViewController {
    
    var forum: Forum?
    var forumID: String?
    var comments = [String:Comment]()
    var commentKeys = [String]()
    var user: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    var db: Firestore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib1 = UINib(nibName: "ForumPostTableViewCell", bundle: nil)
        let cellNib2 = UINib(nibName: "PostCommentTableViewCell", bundle: nil)
        let cellNib3 = UINib(nibName: "TableViewCell1", bundle: nil)
        tableView.register(cellNib1, forCellReuseIdentifier: "forumPostCell")
        tableView.register(cellNib2, forCellReuseIdentifier: "postCommentCell")
        tableView.register(cellNib3, forCellReuseIdentifier: "comment")

        db = Firestore.firestore()
        
        if let user = Auth.auth().currentUser {
            self.user = user
            db!.collection("forums").document(forumID!).collection("comments").addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error retreiving collection: \(error)")
                } else {
                    let documents = querySnapshot?.documents
                    
                    for document in documents! {
                        
                        let data = document.data()
                        self.comments[document.documentID] = Comment(userID: data["userID"] as! String, message: data["message"] as! String, name: data["name"] as! String)
                    }
                    
                    self.commentKeys.removeAll()
                    self.commentKeys.append(contentsOf: self.comments.keys)
                    self.tableView.reloadData()
                    
                    querySnapshot?.documentChanges.forEach({ diff in
                        let document = diff.document
                        let data = document.data()
                        
                        if (diff.type == .added || diff.type == .modified) {
                            self.comments[document.documentID] = Comment(userID: data["userID"] as! String, message: data["message"] as! String, name: data["name"] as! String)
                        }
                        if (diff.type == .removed) {
                            self.comments.removeValue(forKey: document.documentID)
                        }
                        
                        self.commentKeys.removeAll()
                        self.commentKeys.append(contentsOf: self.comments.keys)
                        self.tableView.reloadData()
                    })
                }
            }
        }
    }

}


extension ForumDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return comments.count
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "forumPostCell", for: indexPath) as! ForumPostTableViewCell
            
            cell.nameLabel.text = forum!.name
            cell.messageLabel.text = forum!.message
            cell.likesLabel.text = "likes " + String(forum!.likes.count)
            
            if let like = forum!.likes[(user?.uid)!], like == true {
                cell.likeBtn.setImage(#imageLiteral(resourceName: "like_favorite"), for: .normal)
            } else {
                cell.likeBtn.setImage(#imageLiteral(resourceName: "like_not_favorite"), for: .normal)
            }
        
            cell.delegate = self
            
            return cell
        } else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCommentCell", for: indexPath) as! PostCommentTableViewCell
            
            cell.delegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! TableViewCell1
            
            let comment = comments[commentKeys[indexPath.row]]!
            
            cell.messageLabel.text = comment.message
            cell.nameLabel.text = comment.name
            
            return cell
        }
    }
}

extension ForumDetailsViewController: ForumPostTableViewCellDelegate, PostCommentTableViewCellDelegate {
    func postComment(cell: PostCommentTableViewCell) {
        if let comment = cell.commentField.text, comment != "" {
            var ref: DocumentReference? = nil
            ref = db!.collection("forums").document(forumID!).collection("comments").addDocument(data: [
                "message" : comment,
                "userID" : user!.uid,
                "name" : user!.displayName!
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
    }
    
    func likeForum(cell: ForumPostTableViewCell) {
        print("like 1")
        if forum!.likes[user!.uid] != true {
            print("like 2")
            forum!.likes[user!.uid] = true
            db?.collection("forums").document(forumID!).setData(["likes" : forum!.likes], merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    self.tableView.reloadData()
                    print("Document successfully written!")
                }
            }
        }
    }
}
