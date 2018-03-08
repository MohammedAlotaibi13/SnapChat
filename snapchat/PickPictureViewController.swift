//
//  PickPictureViewController.swift
//  snapchat
//
//  Created by محمد عايض العتيبي on 19/06/1439 AH.
//  Copyright © 1439 code schoole. All rights reserved.
//

import UIKit
import FirebaseStorage

class PickPictureViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var imagepicker : UIImagePickerController?
    var imageAdded = false
    var imageName = "\(NSUUID().uuidString).jpg"
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker = UIImagePickerController()
        imagepicker?.delegate = self
    }

    @IBAction func selectCamera(_ sender: Any) {
        if imagepicker != nil {
        imagepicker?.sourceType = .camera
        present(imagepicker!, animated: true, completion: nil)
        }
    }
    @IBAction func selectFromLibrary(_ sender: Any) {
        if imagepicker != nil {
        imagepicker?.sourceType = .photoLibrary
        present(imagepicker!, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageAdded = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if imageAdded && messageTextField.text! != "" {
            let imageFolder = Storage.storage().reference().child("images")
            if let image = imageView.image {
                if let imageData = UIImageJPEGRepresentation(image, 0.1){
                    imageFolder.child(imageName).putData(imageData, metadata: nil, completion: { (metdata, error) in
                        if error != nil {
                            Alert.alert("Error", (error?.localizedDescription)!, in: self)
                        } else{
                            if let downloadUrl = metdata?.downloadURL()?.absoluteString  {
                           self.performSegue(withIdentifier: "toResultSnapChats", sender: downloadUrl)
                            }
                        }
                    })
            }
            }
            
        } else {
            Alert.alert("Missing", "You missed message or photo ", in: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let downloadUrl = sender as? String {
            if let selectVc = segue.destination as? ResultSnapsTableViewController {
                selectVc.downloadUrl = downloadUrl
                selectVc.photoDescription = messageTextField.text!
                selectVc.imageName = imageName
            }
        }
    }
}
