//
//  RatesView.swift
//  CurrenciesConverter
//
//  Created by Karina gurachevskaya on 2.12.22.
//

import SwiftUI

struct RatesView: View {

    @StateObject var viewModel: RatesViewModel
        
    var body: some View {
        Group {
            if viewModel.fetchState == .success {
                List {
                    ForEach(viewModel.fetchedCurrencies, id: \.symbol) { currency in
                        Text(viewModel.rate(for: currency))
                    }
                }
            } else {
                Text(viewModel.fetchState == .fetching
                     ? "Fetching..."
                     : "Fetch failed")
            }
        }
        .navigationTitle("\(Int(viewModel.amount)) \(viewModel.baseCurrency.rawValue)")
        .onAppear(perform: viewModel.fetchData)
    }
}

struct RatesView_Previews: PreviewProvider {
    static var previews: some View {
        RatesView(
            viewModel: RatesViewModel(
                amount: 500,
                baseCurrency: .aud
            )
        )
    }
}
