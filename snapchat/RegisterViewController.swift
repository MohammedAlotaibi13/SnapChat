//
//  RegisterViewController.swift
//  snapchat
//
//  Created by محمد عايض العتيبي on 18/06/1439 AH.
//  Copyright © 1439 code schoole. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var signUpMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    self.performSegue(withIdentifier: "moveToSnap", sender: nil)
                    print("sign up successfuly")
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

