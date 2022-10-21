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

    @IBOutlet weak var emailText: UITextField! {
        didSet {
            emailText.leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            let image = UIImage(systemName: "mail")
            imageView.image = image
            emailText.leftView = imageView
        }
    }
    
    @IBOutlet weak var passwordText: UITextField! {
        didSet {
            passwordText.leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            let image = UIImage(systemName: "lock")
            imageView.image = image
            passwordText.leftView = imageView
        }
    }
    
    @IBOutlet weak var showPasswordButton: UIButton!
    
    var emailName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailText.text = emailName
        
        self.navigationItem.hidesBackButton = true
        passwordText.isSecureTextEntry = true
        
    }
    
    @IBAction func showPasswordClicked(_ sender: Any) {
        if passwordText.text != "" {
            if passwordText.isSecureTextEntry == true {
                passwordText.isSecureTextEntry = false
                showPasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            } else {
                passwordText.isSecureTextEntry = true
                showPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
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
        
        performSegue(withIdentifier: "fromSignInVcToSignUpVc", sender: nil)
    }
    
    func makeAlert(titleInput: String, massageInput: String) {
        
        let alert = UIAlertController(title: titleInput, message: massageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }

}
