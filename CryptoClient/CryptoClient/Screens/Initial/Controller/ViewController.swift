//
//  ViewController.swift
//  CryptoClient
//
//  Created by Batuhan PAMUKÇU (Mobil Uygulama Geliştirme-Yazılım Uzmanı III) on 29.09.2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedRow: Int = 0
    
    var cryptoCurrencies = [CryptoCurrency]() /*{
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        cell.coinImage.kf.setImage(with: URL(string: cryptoCurrencies[indexPath.row].icon))
        cell.symbolLabel.text = cryptoCurrencies[indexPath.row].symbol
        cell.currencyText.text = cryptoCurrencies[indexPath.row].name
        cell.priceText.text = String("$ \(cryptoCurrencies[indexPath.row].price)".split(separator: ".")[0]) + "," + String("\(cryptoCurrencies[indexPath.row].price)".split(separator: ".")[1].prefix(2))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "toDetailsViewController", sender: nil)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsViewController" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.detail = cryptoCurrencies[selectedRow]
        }
    }
    
    func getData() {
        let url = URL(string: "https://api.coinstats.app/public/v1/coins")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                if data != nil {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CryptoCurrencyResponse.self, from: data!)
                        self.cryptoCurrencies = result.coins!
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
        
        task.resume()
    }
}
