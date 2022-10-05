//
//  ViewController.swift
//  CryptoClient
//
//  Created by Batuhan PAMUKÇU (Mobil Uygulama Geliştirme-Yazılım Uzmanı III) on 29.09.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var cryptoCurrencies = [CryptoCurrency]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getdata()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell ()
        cell.textLabel?.text = cryptoCurrencies[indexPath.row].name.capitalized
        return cell
    }
    
    func getdata() {
        let url = URL(string: "https://api.coinstats.app/public/v1/coins")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                if data != nil {
                    do {
                        /*let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]*/
                        
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CryptoCurrencyResponse.self, from: data!)
                        self.cryptoCurrencies = result.coins!
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
        
        task.resume()
    }

    /*
    func getData() {
        
        let url = URL(string: "https://api.coinstats.app/public/v1/coins")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("error")
            } else {
                if data != nil {
                    do {
                        let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                        
                        print(json)
                        
                    } catch {
                        print("error")
                    }
                }
            }
            
        }
        
        task.resume()
    }
    */

}

