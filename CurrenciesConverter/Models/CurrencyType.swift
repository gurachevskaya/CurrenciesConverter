//
//  CurrencyType.swift
//  CurrenciesConverter
//
//  Created by Karina gurachevskaya on 2.12.22.
//

import SwiftUI

enum CurrencyType: String, Codable, CaseIterable {
    case usd, aud, cad, chf, cny, eur, gbp, hkd, jpy, sgd
    
    static let defaultCurrencies: [CurrencyType] = [.usd, .eur]
    
    static func save(currencies: [CurrencyType]) {
        let data = try! JSONEncoder().encode(currencies)
        UserDefaults.standard.set(data, forKey: Constants.Keys.selectedCurrenciesKey)
    }
    
    static func getCurrencies() -> [CurrencyType] {
        do {
            if let data = UserDefaults.standard.data(forKey: Constants.Keys.selectedCurrenciesKey) {
                let currencies = try JSONDecoder().decode([CurrencyType].self, from: data)
                return currencies
            }
        } catch {
            // Do nothing: nothing was found
        }
        
        return defaultCurrencies
    }
}
