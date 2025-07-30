//
//  WeatherLandingViewModel.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 23/07/25.
//

import SwiftUI

private struct Constants {
    static let errorMessage = "Something went wrong."
}

final class WeatherLandingViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var status: LoadingState = .idle
    
    private var repository: WeatherRepositoryProtocol
    
    init(repostory: WeatherRepositoryProtocol) {
        self.repository = repostory
    }
    
    func fetchCities() {
        status = .loading
        do {
            cities = try repository.fetchCities()
            status = .loaded
        } catch {
            handle(error)
        }
    }
    
    func addCity(_ city: String) {
        let city = City(cityName: city)
        do {
            try repository.create(city: city)
            fetchCities()
        } catch {
            handle(error)
        }
    }
    
    func deleteCity(_ city: City) {
        do {
            try repository.delete(city: city)
            fetchCities()
        } catch {
            handle(error)
        }
    }
    
    private func handle(_ error: Error) {
        status = .error((error as? LocalizedError)?.errorDescription ?? Constants.errorMessage)
    }
}


// Remove later, added for previews.
#if DEBUG
extension WeatherLandingViewModel {
    static var preview: WeatherLandingViewModel {
        let viewModel = WeatherLandingViewModel(repostory: WeatherRepository(storageService: WeatherStorageService()))
        viewModel.cities = mockCities
        return viewModel
    }
    
    static let mockCities = [City(cityName: "New York"),
                             City(cityName: "Los Angeles"),
                             City(cityName: "Gurugram"),
                             ]
                             
}
#endif
