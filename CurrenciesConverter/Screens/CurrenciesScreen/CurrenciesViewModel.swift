//
//  CurrenciesViewModel.swift
//  CurrenciesConverter
//
//  Created by Karina gurachevskaya on 4.12.22.
//

import SwiftUI

class CurrenciesViewModel: ObservableObject {
    @Published var selectedCurrencies: [CurrencyType] = CurrencyType.getCurrencies()
    
    let selectedColor: Color = .init(red: 0, green: 0.55, blue: 0.25)
    let deselectedColor: Color = .init(red: 0.3, green: 0, blue: 0)
    
    func toggle(_ currency: CurrencyType) {
        if let index = selectedCurrencies.firstIndex(of: currency) {
            selectedCurrencies.remove(at: index)
        } else {
            selectedCurrencies.append(currency)
        }
        
        CurrencyType.save(currencies: selectedCurrencies)
    }
}
