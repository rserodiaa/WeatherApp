//
//  WeatherLandingViewModel.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 23/07/25.
//

import SwiftUI

final class WeatherLandingViewModel: ObservableObject {
    @Published var cities: [City] = ["Gurugram", "New York", "Los Angeles"].map { City(cityName: $0) }
    @Published var status: LoadingState = .idle
    @Published var errorMessage: String?
}


// Remove later, added for previews.
#if DEBUG
extension WeatherLandingViewModel {
    static var preview: WeatherLandingViewModel {
        let viewModel = WeatherLandingViewModel()
        viewModel.cities = mockCities
        return viewModel
    }
    
    static let mockCities = [City(cityName: "New York"),
                             City(cityName: "Los Angeles"),
                             City(cityName: "Gurugram"),
                             ]
                             
}
#endif
