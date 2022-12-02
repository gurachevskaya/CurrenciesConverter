//
//  CurrenciesScreen.swift
//  CurrenciesConverter
//
//  Created by Karina gurachevskaya on 2.12.22.
//

import SwiftUI

struct CurrenciesScreen: View {
    @State private var selectedCurrencies: [CurrencyType] = CurrencyType.getCurrencies()
    
    let selectedColor: Color = .init(red: 0, green: 0.55, blue: 0.25)
    let deselectedColor: Color = .init(red: 0.3, green: 0, blue: 0)
    
    var body: some View {
        NavigationStack {
            List(CurrencyType.allCases, id: \.self) { currency in
                Button(currency.rawValue.capitalized) {
                    toggle(currency)
                }
                .listItemTint(
                    selectedCurrencies.contains(currency)
                    ? selectedColor
                    : deselectedColor
                )
            }
            .listStyle(.carousel)
            .navigationTitle("Currencies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension CurrenciesScreen {
    private func toggle(_ currency: CurrencyType) {
        if let index = selectedCurrencies.firstIndex(of: currency) {
            selectedCurrencies.remove(at: index)
        } else {
            selectedCurrencies.append(currency)
        }
        
//        CurrencyType.save(currencies: selectedCurrencies)
    }
}

struct CurrenciesScreen_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesScreen()
    }
}
