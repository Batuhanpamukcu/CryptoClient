//
//  DetailsViewController.swift
//  CryptoClient
//
//  Created by Batuhan PAMUKÇU (Mobil Uygulama Geliştirme-Yazılım Uzmanı III) on 6.10.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var detail: CryptoCurrency = CryptoCurrency(id: "", icon: "", name: "", symbol: "", rank: 0, price: 0.0, priceBtc: 0.0, volume: 0.0, marketCap: 0.0, availableSupply: 0.0, totalSupply: 0.0, priceChange1H: 0.0, priceChange1D: 0.0, priceChange1W: 0.0, websiteURL: "", twitterURL: "", exp: [""], contractAddress: "", decimals: 0, redditURL: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinNameLabel.text = detail.name
        priceLabel.text = String("\(detail.price)".split(separator: ".")[0]) + "," +  String("\(detail.price)".split(separator: ".")[1].prefix(4))

        // Do any additional setup after loading the view.
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
