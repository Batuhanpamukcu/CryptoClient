//
//  SignInViewController.swift
//  CryptoClient
//
//  Created by Batuhan PAMUKÇU (Mobil Uygulama Geliştirme-Yazılım Uzmanı III) on 18.10.2022.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func signInClicked(_ sender: Any) {
        performSegue(withIdentifier: "mainSegue", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
