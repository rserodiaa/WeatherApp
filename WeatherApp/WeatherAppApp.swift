//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 21/07/25.
//

import SwiftUI

private struct Constants {
    static let weatherAPIKey = "weather_api_key"
    static let airVisualAPIKey = "airvisual_api_key"
}

@main
struct WeatherAppApp: App {
    init() {
        let keyExists = KeychainHelper.shared.read(forKey: Constants.weatherAPIKey) != nil
        if !keyExists {
            // hardcoded API key for testing purposes, must be injected via configs.
            KeychainHelper.shared.save("bbd31ea31566748bf30c141164d48c60", forKey: Constants.weatherAPIKey)
        }
        let avKeyExists = KeychainHelper.shared.read(forKey: Constants.airVisualAPIKey) != nil
        if !avKeyExists {
            // hardcoded API key for testing purposes, must be injected via configs.
            KeychainHelper.shared.save("b9f2d98a-d2bc-44d0-b41c-cb9d81d16b62", forKey: Constants.airVisualAPIKey)
        }
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
        }
    }
}
