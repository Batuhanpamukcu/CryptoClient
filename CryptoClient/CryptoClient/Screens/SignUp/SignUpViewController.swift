//
//  SignUpViewController.swift
//  CryptoClient
//
//  Created by Batuhan PAMUKÇU (Mobil Uygulama Geliştirme-Yazılım Uzmanı III) on 21.10.2022.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

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
    
    @IBOutlet weak var againPasswordText: UITextField! {
        didSet {
            againPasswordText.leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            let image = UIImage(systemName: "lock")
            imageView.image = image
            againPasswordText.leftView = imageView
        }
    }
    
    var emailName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" && againPasswordText.text != "" {
            if passwordText.text == againPasswordText.text {
                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                    if let error = error {
                        self.makeAlert(titleInput: "Error", massageInput: error.localizedDescription)
                    } else {
                        do {
                            try Auth.auth().signOut()
                        }
                        catch {
                            print("Error")
                        }
                        
                        self.emailName = self.emailText.text!
                        self.performSegue(withIdentifier: "fromSignUpVcToSignInVc", sender: nil)
                    }
                }
            } else {
                makeAlert(titleInput: "Error", massageInput: "Passwords are no match")
            }
            
        } else {
            makeAlert(titleInput: "Error", massageInput: "email and password must be entered")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSignUpVcToSignInVc" {
            let destinationVC = segue.destination as! SignInViewController
            destinationVC.emailName = emailName
        }
    }
    
    func makeAlert(titleInput: String, massageInput: String) {
        
        let alert = UIAlertController(title: titleInput, message: massageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}
