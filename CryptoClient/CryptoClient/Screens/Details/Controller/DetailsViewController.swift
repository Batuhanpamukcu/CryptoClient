//
//  DetailsViewController.swift
//  CryptoClient
//
//  Created by Batuhan PAMUKÇU (Mobil Uygulama Geliştirme-Yazılım Uzmanı III) on 6.10.2022.
//

import UIKit
import Kingfisher
import Charts

class DetailsViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coinImageView: UIImageView!
    
    var detail: CryptoCurrency = CryptoCurrency(id: "", icon: "", name: "", symbol: "", rank: 0, price: 0.0, priceBtc: 0.0, volume: 0.0, marketCap: 0.0, availableSupply: 0.0, totalSupply: 0.0, priceChange1H: 0.0, priceChange1D: 0.0, priceChange1W: 0.0, websiteURL: "", twitterURL: "", exp: [""], contractAddress: "", decimals: 0, redditURL: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCoinDetailsData(detail: detail)
        
        coinImageView.kf.setImage(with: URL(string: detail.icon))
        coinNameLabel.text = detail.name
        priceLabel.text = String("$ \(detail.price)".split(separator: ".")[0]) + "," +  String("$ \(detail.price)".split(separator: ".")[1].prefix(2))
        
    }
    
    func getCoinDetailsData(detail: CryptoCurrency) {
        let url = URL(string: "https://api.coinstats.app/public/v1/charts?period=1w&coinId=\(detail.id)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                if data != nil {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CoinPrices.self, from: data!)
                                                
                        DispatchQueue.main.async {
                            var entries = [ChartDataEntry]()
                            for group in result.chart {
                                entries.append(ChartDataEntry(x: group[0], y: group[1]))
                            }
                            let set = LineChartDataSet(entries: entries)
                            let data = LineChartData(dataSet: set)
                            self.lineChartView.data = data
                            
                            set.colors = ChartColorTemplates.liberty()
                            set.drawCirclesEnabled = false
                            set.lineWidth = 1.7
                            set.setColor(.red)
                            
                            self.lineChartView.doubleTapToZoomEnabled = false
                            self.lineChartView.drawGridBackgroundEnabled = true
                            self.lineChartView.gridBackgroundColor = .white
                            self.lineChartView.xAxis.enabled = false
                            self.lineChartView.leftAxis.enabled = false
                            self.lineChartView.chartDescription?.enabled = false
                            self.lineChartView.legend.enabled = false
                            self.lineChartView.animate(xAxisDuration: 2)
                            
                            let marker = PillMarker(color: .white, font: UIFont.boldSystemFont(ofSize: 14), textColor: .black)
                            self.lineChartView.marker = marker
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
