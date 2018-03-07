//
//  PickPictureViewController.swift
//  snapchat
//
//  Created by محمد عايض العتيبي on 19/06/1439 AH.
//  Copyright © 1439 code schoole. All rights reserved.
//

import UIKit

class PickPictureViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var imagepicker : UIImagePickerController?
    var imageAdded = false
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
            
        } else {
            Alert.alert("Missing", "You missed message or photo ", in: self)
        }
    }
}
