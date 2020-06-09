//
//  CurrencyModel.swift
//  HSE Test
//
//  Created by Kostya Bunsberry on 07.06.2020.
//  Copyright © 2020 Kostya Bunsberry. All rights reserved.
//

import Foundation

class CurrencyModel {
    var name = ""
    var code = ""
    var country = ""
    
    init(name: String, code: String, country: String) {
        self.name = name
        self.code = code
        self.country = country
    }
}
