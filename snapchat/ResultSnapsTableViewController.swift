//
//  ResultSnapsTableViewController.swift
//  snapchat
//
//  Created by محمد عايض العتيبي on 20/06/1439 AH.
//  Copyright © 1439 code schoole. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
// MARK:- ResultSnapsTableViewController
class ResultSnapsTableViewController: UITableViewController {
    // MARK: Varibles
    var downloadUrl = ""
    var photoDescription = ""
    var imageName = ""
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("user").observe(.childAdded) { (snapShot) in
            let user = User()
            if let userDictionary = snapShot.value as? NSDictionary {
                if let email = userDictionary["email"] as? String {
                    user.email = email
                    user.uid = snapShot.key
                    self.users.append(user)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        if let userEmail = Auth.auth().currentUser?.email {
            let snap = ["from" : userEmail , "decription" : photoDescription , "imageUrl" : downloadUrl , "imageName" : imageName]
            Database.database().reference().child("user").child(user.uid).child("snaps").childByAutoId().setValue(snap)
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
}

// MARK:- User
class User {
    var email = ""
    var uid = ""
}
