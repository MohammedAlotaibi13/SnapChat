//
//  SnapTableViewController.swift
//  snapchat
//
//  Created by محمد عايض العتيبي on 19/06/1439 AH.
//  Copyright © 1439 code schoole. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapTableViewController: UITableViewController {
    
    var snaps : [DataSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUserUid = Auth.auth().currentUser?.uid{
            Database.database().reference().child("user").child(currentUserUid).child("snaps").observe(.childAdded, with: { (snapShot) in
                self.snaps.append(snapShot)
                self.tableView.reloadData()
                
                Database.database().reference().child("user").child(currentUserUid).child("snaps").observe(.childRemoved, with: { (snapShot) in
                    var index = 0
                    for snap in self.snaps {
                        if snapShot.key == snap.key {
                            self.snaps.remove(at: index)
                        }
                        index += 1
                    }
                    self.tableView.reloadData()
                })
            })
        }

    }

    @IBAction func logOut(_ sender: Any) {
        do {
          try Auth.auth().signOut()
        } catch {
            print("problem to logout")
        }
        dismiss(animated: true, completion: nil)
        
    }
    

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return snaps.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         let snaps = self.snaps[indexPath.row]
        if let userDictionary = snaps.value as? NSDictionary {
            if let fromEmail = userDictionary["from"] as? String {
                cell.textLabel?.text = fromEmail
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snaps = self.snaps[indexPath.row]
        performSegue(withIdentifier: "showSnaps", sender: snaps)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSnaps" {
            if let selectVc = segue.destination as? ShowSnapsViewController {
                if let snaps = sender as? DataSnapshot {
                    selectVc.snaps = snaps
                }
            }
        }
    }
}
