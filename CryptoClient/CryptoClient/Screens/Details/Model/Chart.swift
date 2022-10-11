//
//  Chart.swift
//  CryptoClient
//
//  Created by Batuhan PAMUKÇU (Mobil Uygulama Geliştirme-Yazılım Uzmanı III) on 10.10.2022.
//

import Foundation

struct CoinPrices : Decodable {
    let chart: [[Double]]
}
