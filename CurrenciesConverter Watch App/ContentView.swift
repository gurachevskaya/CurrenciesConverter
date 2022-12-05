//
//  ContentView.swift
//  CurrenciesConverter Watch App
//
//  Created by Karina gurachevskaya on 2.12.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
            CurrenciesScreen(viewModel: CurrenciesViewModel())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
