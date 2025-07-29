//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 21/07/25.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    init() {
        let keyExists = KeychainHelper.shared.read(forKey: AppConstants.weatherAPIKey) != nil
            if !keyExists {
                // hardcoded API key for testing purposes, must be injected via configs.
                KeychainHelper.shared.save("bbd31ea31566748bf30c141164d48c60", forKey: "weather_api_key")
            }
        }

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // setup later
            WeatherLandingView(viewModel: WeatherLandingViewModel())
        }
    }
}
