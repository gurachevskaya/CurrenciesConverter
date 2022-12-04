//
//  CurrenciesScreen.swift
//  CurrenciesConverter
//
//  Created by Karina gurachevskaya on 2.12.22.
//

import SwiftUI

struct CurrenciesScreen: View {
    
    @StateObject var viewModel: CurrenciesViewModel
    
    var body: some View {
        NavigationStack {
            List(CurrencyType.allCases, id: \.self) { currency in
                Button(currency.rawValue.capitalized) {
                    viewModel.toggle(currency)
                }
                .listItemTint(
                    viewModel.selectedCurrencies.contains(currency)
                    ? viewModel.selectedColor
                    : viewModel.deselectedColor
                )
            }
            .listStyle(.carousel)
            .navigationTitle("Currencies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CurrenciesScreen_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesScreen(viewModel: CurrenciesViewModel())
    }
}
