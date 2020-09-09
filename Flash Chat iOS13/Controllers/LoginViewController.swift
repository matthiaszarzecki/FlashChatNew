//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Shruti on 21/05/2020.
//  Copyright © 2020 Shruti. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("Error is -  \(e.localizedDescription)!")
                    
                    // create the alert
                    let alert = UIAlertController(title: "My Title", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    //Navigate to the ChatViewController
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    //self.performSegue(withIdentifier: "LoginToChat", sender: self)

                }
            }
        }
    }
    
}
