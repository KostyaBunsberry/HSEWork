//
//  Data.swift
//  HSE Test
//
//  Created by Kostya Bunsberry on 07.06.2020.
//  Copyright © 2020 Kostya Bunsberry. All rights reserved.
//

import Foundation

class Data {
    class func getData() -> [CurrencyModel] {
        var data = [CurrencyModel]()
        
        data.append(CurrencyModel(name: "Yuan (元)", code: "CNY", country: "China"))
        data.append(CurrencyModel(name: "Dollar ($)", code: "USD", country: "USA"))
        data.append(CurrencyModel(name: "Ruble (₽)", code: "RUB", country: "Russia"))
        data.append(CurrencyModel(name: "Euro (€)", code: "EUR", country: "EU"))
        data.append(CurrencyModel(name: "Pound (£)", code: "GBP", country: "Britain"))
        data.append(CurrencyModel(name: "Yen (¥)", code: "JPY", country: "Japan"))
        data.append(CurrencyModel(name: "Krona", code: "SEK", country: "Sweden"))
        
        return data
    }
}
