//
//  ShowSnapsViewController.swift
//  snapchat
//
//  Created by محمد عايض العتيبي on 20/06/1439 AH.
//  Copyright © 1439 code schoole. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage
import FirebaseAuth
import FirebaseStorage
// MARK:- ShowSnapsViewController
class ShowSnapsViewController: UIViewController {
    // MARK: Outlet
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    // MARK: Varibles
    var imageName = ""
    
    var snaps : DataSnapshot?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let snpsDictionary = snaps?.value as? NSDictionary{
            if let description = snpsDictionary["decription"] as? String {
                if let imagUrl =   snpsDictionary["imageUrl"] as? String {
                    if let imageName = snpsDictionary["imageName"] as? String{
                        message.text = description
                        self.imageName = imageName
                        if let url = URL(string: imagUrl) {
                            imageView.sd_setImage(with: url)
                        }
                    }
                }
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let cuurentUserUid = Auth.auth().currentUser?.uid {
            if let snapKey = snaps?.key {
                Database.database().reference().child("user").child(cuurentUserUid).child("snaps").child(snapKey).removeValue()
                Storage.storage().reference().child("images").child(imageName).delete(completion: nil)
            }
        }
    }
    
}
