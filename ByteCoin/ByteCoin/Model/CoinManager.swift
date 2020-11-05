//
//  CoinManager.swift
//  ByteCoin
//
//  Created by MAC on 04.11.2020.
//  Copyright © 2020 Litmax. All rights reserved.
//

import Foundation

protocol UpdateBitcoin {
    func getData(manager: CoinManager, model: Rate)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "9AED5F63-4FBD-484B-A8F0-F8DE2430A03D"
    
    var delegate: UpdateBitcoin?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        guard let url = URL(string: "\(baseURL)?apikey=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let dataUnwrap = data {
                
                if let decodedData = decodeJSON(data: dataUnwrap)  {
                    
                    for element in decodedData.rates {
                        
                        if element.assetIDQuote == currency {
                            delegate?.getData(manager: self, model: element)
                        }
                    }
                    
                } else { print(error!.localizedDescription) }
            }
        }.resume()
    }
    
    func decodeJSON(data: Data) -> BitModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let model = try decoder.decode(BitModel.self, from: data)
            let idBase = model.assetIDBase
            let rates = model.rates
            
            let bitModel = BitModel(assetIDBase: idBase, rates: rates)
            return bitModel
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
