//
//  RegisterViewController.swift
//  snapchat
//
//  Created by محمد عايض العتيبي on 18/06/1439 AH.
//  Copyright © 1439 code schoole. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
// MARK:- RegisterViewController
class RegisterViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    // MARK: varibale
    var signUpMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        if signUpMode{
            signUpMode = false
            logIn.setTitle("Log In", for: .normal)
            signUp.setTitle("Sign Up", for: .normal)
        } else {
            signUpMode = true
            logIn.setTitle("Sign Up", for: .normal)
            signUp.setTitle("Log In", for: .normal)
        }
    }
    @IBAction func logIn(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            Alert.alert("Missing", "Please Enter Your Email or Password", in: self)
        } else {
            if signUpMode {
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                    if error !=  nil {
                        Alert.alert("Error", (error?.localizedDescription)!, in: self)
                    }else{
                        if let user = user {
                            Database.database().reference().child("user").child(user.uid).child("email").setValue(user.email)
                            self.performSegue(withIdentifier: "moveToSnap", sender: nil)
                        }
                    }
                })
            } else{
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                    if error != nil {
                        Alert.alert("Error", (error?.localizedDescription)!, in: self)
                    }else {
                        self.performSegue(withIdentifier: "moveToSnap", sender: nil)
                        print("log in done")
                    }
                })
            }
        }
        
    }
    
}

