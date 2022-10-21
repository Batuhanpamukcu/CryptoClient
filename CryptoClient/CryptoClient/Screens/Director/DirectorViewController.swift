//
//  DirectorViewController.swift
//  CryptoClient
//
//  Created by Batuhan PAMUKÇU (Mobil Uygulama Geliştirme-Yazılım Uzmanı III) on 20.10.2022.
//

import UIKit
import Firebase

class DirectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            if Auth.auth().currentUser != nil {
                self.performSegue(withIdentifier: "fromDirectorToDetailsVC", sender: nil)
                
            } else {
                self.performSegue(withIdentifier: "fromDirectorToViewController", sender: nil)
            }
        }
        
    }
}
