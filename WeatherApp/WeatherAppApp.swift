//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 21/07/25.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // setup later
            WeatherLandingView(viewModel: WeatherLandingViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
