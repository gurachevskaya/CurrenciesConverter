//
//  CurrenciesNetworkManager.swift
//  CurrenciesConverter
//
//  Created by Karina gurachevskaya on 2.12.22.
//

import Foundation
import Combine

struct CurrenciesNetworkManager {
    static let shared = CurrenciesNetworkManager()
    
    private init() {}
    
    func fetchRates(baseCurrency: CurrencyType) -> AnyPublisher<CurrencyResult, Never> {
        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=\(EnvironmentConstants.apiKey)&base=\(baseCurrency.rawValue)") else {
            return Just(.init(base: "", rates: [:]))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
          .map(\.data)
          .decode(type: CurrencyResult.self, decoder: JSONDecoder())
          .replaceError(with: .init(base: "", rates: [:]))
          .eraseToAnyPublisher()
    }
}
