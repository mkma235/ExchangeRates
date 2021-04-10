//
//  BaseRate.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import Foundation

struct Rate {

    var baseRate: Double
    var exchangeRate: Double
    var baseSelect: Base
    var convert2JPY: Double
    var convert2GBP: Double
    var convert2MXN: Double
    
    init(baseRate: Double, exchangeRate: Double, baseSelect: Base, convert2JPY: Double, convert2GBP: Double, convert2MXN: Double) {
        self.baseRate = baseRate
        self.exchangeRate = exchangeRate
        self.baseSelect = baseSelect
        self.convert2JPY = convert2JPY
        self.convert2GBP = convert2GBP
        self.convert2MXN = convert2MXN
    }
    
    enum Base: String, CaseIterable {
        case USD = "🇺🇸"
        case EUR = "🇪🇺"
    }
}
