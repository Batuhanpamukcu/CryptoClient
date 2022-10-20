//
//  SignInViewController.swift
//  CryptoClient
//
//  Created by Batuhan PAMUKÇU (Mobil Uygulama Geliştirme-Yazılım Uzmanı III) on 18.10.2022.
//

import UIKit
import Firebase
import SwiftUI

class SignInViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var showPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        passwordText.isSecureTextEntry = true
        
        /*
        showPasswordButton.setImage(UIImage(named: "eye"), for: .normal)
        showPasswordButton.imageView?.contentMode = .scaleAspectFill
        */
    }
    
    @IBAction func showPasswordClicked(_ sender: Any) {
        if passwordText.text != "" {
            if passwordText.isSecureTextEntry == true {
                passwordText.isSecureTextEntry = false
            } else {
                passwordText.isSecureTextEntry = true
            }
        }
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if let error = error {
                    self.makeAlert(titleInput: "Error", massageInput: error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "mainSegue", sender: nil)
                }
                
            }
        } else {
            makeAlert(titleInput: "Error", massageInput: "email and password must be entered")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if let error = error {
                    self.makeAlert(titleInput: "Error", massageInput: error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "mainSegue", sender: nil)
                }
            }
        } else {
            makeAlert(titleInput: "Error", massageInput: "email and password must be entered")
        }
    }
    
    func makeAlert(titleInput: String, massageInput: String) {
        
        let alert = UIAlertController(title: titleInput, message: massageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }

}
