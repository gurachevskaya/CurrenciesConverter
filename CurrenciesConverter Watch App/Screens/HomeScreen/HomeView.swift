//
//  HomeView.swift
//  CurrenciesConverter
//
//  Created by Karina gurachevskaya on 4.12.22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                VStack(spacing: 0) {
                    Text("\(Int(viewModel.amount))")
                        .font(.system(size: 52))
                        .padding()
                        .frame(width: geo.size.width)
                        .contentShape(Rectangle()) // increment touch area
                        .focusable { viewModel.amountFocused = $0 }
//                        .focused($amountFocused)
                        .digitalCrownRotation($viewModel.amount, from: 0, through: 1000, by: 20, sensitivity: .high, isContinuous: false, isHapticFeedbackEnabled: true)
                    // isContinuous means we go back to 0 after 1000
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(viewModel.amountFocused ? Color.green : Color.white, lineWidth: 1)
                        )
                        .padding(.bottom)
                    HStack {
                        Picker("Select a currency", selection: $viewModel.selectedCurrency) {
                            ForEach(CurrencyType.allCases, id: \.self) { currency in
                                Text(currency.rawValue.uppercased())
                            }
                        }
                        .labelsHidden()
                        
//                        NavigationLink(value: viewModel.selectedCurrency) {
//                            Text("Go")
//                        }
//                        .frame(width: geo.size.width * 0.4)
                    }
                    .frame(width: geo.size.width)
                    .navigationDestination(for: CurrencyType.self) { currency in
                        RatesView(
                            viewModel: RatesViewModel(
                                amount: viewModel.amount,
                                baseCurrency: viewModel.selectedCurrency
                            )
                        )
                    }
                }
            }
        }
    }
}
    
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
