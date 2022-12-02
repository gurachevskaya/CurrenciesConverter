//
//  EnvironmentConstants.swift
//  CurrenciesConverter
//
//  Created by Karina gurachevskaya on 2.12.22.
//

import Foundation

enum EnvironmentConstants {
    static var apiKey: String {
        guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("❌ -> Environment variable [API_Key] was not found. Did you forget to add it in scheme?")
        }
        
        return key
    }
}
