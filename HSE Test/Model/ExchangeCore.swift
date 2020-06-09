//
//  ExchangeCore.swift
//  HSE Test
//
//  Created by Kostya Bunsberry on 08.06.2020.
//  Copyright © 2020 Kostya Bunsberry. All rights reserved.
//

import Foundation

class ExchangeCore {
    var firstCurrency: String
    var secondCurrency: String
    var multiplier: Double
    
    func newFirst(_ value: String) {
        self.firstCurrency = value
        newMultiplier()
    }
    
    func newSecond(_ value: String) {
        self.secondCurrency = value
        newMultiplier()
    }
    
    func newMultiplier() {
        print("First: \(self.firstCurrency), Second: \(self.secondCurrency)")
        
        var request = URLRequest(url: URL(string: "https://api.exchangeratesapi.io/latest?base=\(self.firstCurrency)")!)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                if let rates = json["rates"] as? Dictionary<String, Double> {
                    
                    let index = rates.index(forKey: self.secondCurrency)
                    
                    if (index != nil) {
                        print(rates[index!].value)
                        self.multiplier = rates[index!].value
                    } else {
                        self.multiplier = 1
                    }
                }
            } catch {
                print("JSON Serialization error")
            }
        }).resume()
    }
    
    init(firstPick: String, secondPick: String) {
        self.firstCurrency = firstPick
        self.secondCurrency = secondPick
        self.multiplier = 1.0
    }
}
