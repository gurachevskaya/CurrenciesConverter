//
//  CurrencyResult.swift
//  CurrenciesConverter
//
//  Created by Karina gurachevskaya on 2.12.22.
//

import Foundation

struct CurrencyResult: Codable {
    let base: String
    let rates: [String: Double]
}
