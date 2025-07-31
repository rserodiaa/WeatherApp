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
            KeychainHelper.shared.save("bbd31ea31566748bf30c141164d48c60", forKey: AppConstants.weatherAPIKey)
        }
        let avKeyExists = KeychainHelper.shared.read(forKey: AppConstants.airVisualAPIKey) != nil
        if !avKeyExists {
            // hardcoded API key for testing purposes, must be injected via configs.
            KeychainHelper.shared.save("b9f2d98a-d2bc-44d0-b41c-cb9d81d16b62", forKey: AppConstants.airVisualAPIKey)
        }
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
        }
    }
}
