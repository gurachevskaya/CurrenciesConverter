//
//  HomeViewModel.swift
//  CurrenciesConverter Watch App
//
//  Created by Karina gurachevskaya on 4.12.22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var amount = UserDefaults.standard.double(forKey: Constants.Keys.previousAmountKey)
    @Published var selectedCurrency: CurrencyType = CurrencyType(rawValue: UserDefaults.standard.string(forKey: Constants.Keys.previousBaseCurrencyKey) ?? "USD") ?? .usd
    @Published var amountFocused: Bool = true
    
}
