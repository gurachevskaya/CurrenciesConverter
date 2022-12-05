//
//  RatesViewModel.swift
//  CurrenciesConverter
//
//  Created by Karina gurachevskaya on 2.12.22.
//

import Foundation
import Combine

final class RatesViewModel: ObservableObject {
    enum FetchState {
        case fetching, success, failed
    }
    
    let amount: Double
    let baseCurrency: CurrencyType
    
    init(
        amount: Double,
        baseCurrency: CurrencyType
    ) {
        self.amount = amount
        self.baseCurrency = baseCurrency
    }
    
    @Published var fetchState = FetchState.fetching
    @Published var fetchedCurrencies = [(symbol: String, rate: Double)]()
    @Published var request: AnyCancellable?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func parse(result: CurrencyResult) {
        if result.rates.isEmpty {
            fetchState = .failed
        } else {
            fetchState = .success
            
            let selectedCurrencies = CurrencyType.getCurrencies()
            
            for symbol in result.rates {
                let currencyType = CurrencyType(rawValue: symbol.key) ?? .usd
                
                // filter th rates so we only show ones the user cares about
                guard selectedCurrencies.contains(currencyType) else { continue}
                let rateName = symbol.key
                let rateValue = symbol.value
                fetchedCurrencies.append((symbol: rateName, rate: rateValue))
            }
            
            fetchedCurrencies.sort {
                $0.symbol < $1.symbol
            }
        }
    }
    
    func rate(for currency: (symbol: String, rate: Double)) -> String {
        let value = currency.rate * amount
        let rate = String(format: "%.2f", value)
        return "\(currency.symbol) \(rate)"
    }
    
    func saveAmountAndBaseCurrency() {
        UserDefaults.standard.set(amount, forKey: Constants.Keys.previousAmountKey)
        UserDefaults.standard.set(baseCurrency.rawValue, forKey: Constants.Keys.previousBaseCurrencyKey)
    }
    
    func fetchData() {
        saveAmountAndBaseCurrency()
        
        CurrenciesNetworkManager.shared.fetchRates(baseCurrency: .usd)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: parse)
            .store(in: &cancellables)
    }
}
