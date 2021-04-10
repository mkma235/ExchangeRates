//
//  BaseRate.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import Foundation

struct BaseRate {
    
    var baseRate: Double
    var exchangeRate: Double
    var baseSelect: Base
    
    init(baseRate: Double, exchangeRate: Double, baseSelect: Base = .USD) {
        self.baseRate = baseRate
        self.exchangeRate = exchangeRate
        self.baseSelect = baseSelect
    }
    
    enum Base: String, CaseIterable {
        case USD = "🇺🇸"
        case EUR = "🇪🇺"
    }
}
