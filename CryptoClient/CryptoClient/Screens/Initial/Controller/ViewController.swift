//
//  ViewController.swift
//  CryptoClient
//
//  Created by Batuhan PAMUKÇU (Mobil Uygulama Geliştirme-Yazılım Uzmanı III) on 29.09.2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedRow: Int = 0
    var filteredData = [CryptoCurrency]()
    var cryptoCurrencies = [CryptoCurrency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        getData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        cell.coinImage.kf.setImage(with: URL(string: filteredData[indexPath.row].icon))
        cell.symbolLabel.text = filteredData[indexPath.row].symbol
        cell.currencyText.text = filteredData[indexPath.row].name
        cell.priceText.text = String("$ \(filteredData[indexPath.row].price)".split(separator: ".")[0]) + "," + String("\(filteredData[indexPath.row].price)".split(separator: ".")[1].prefix(2))
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? cryptoCurrencies : cryptoCurrencies.filter { $0.name.contains(searchText) }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "toDetailsViewController", sender: nil)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsViewController" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.detail = filteredData[selectedRow]
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
                        self.filteredData = self.cryptoCurrencies
                        
                        
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
