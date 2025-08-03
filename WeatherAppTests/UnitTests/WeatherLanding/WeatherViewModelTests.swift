//
//  WeatherViewModelTests.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 02/08/25.
//

@testable import WeatherApp
import Testing

@Suite
struct WeatherLandingViewModelTests {
    var mockRepo: MockWeatherRepository
    let viewModel: WeatherLandingViewModel
    
    init() {
        mockRepo = MockWeatherRepository()
        mockRepo.citiesToReturn = [
                City(cityName: "Delhi"),
                City(cityName: "Gurugram")
            ]
        viewModel = WeatherLandingViewModel(repostory: mockRepo)
    }
    
    @Test
    func fetchCitiesSuccess() {
        viewModel.fetchCities()
        
        #expect(viewModel.status == .loaded)
        #expect(viewModel.cities.count == 2)
        #expect(viewModel.cities.first?.cityName == "Delhi")
    }
    
    @Test
    func fetchCitiesFailure() {
        mockRepo.errorToThrow = CustomErrors.fetchFailed
        viewModel.fetchCities()
        #expect(viewModel.cities.isEmpty)
        #expect(viewModel.status == .error(CustomErrors.fetchFailed.localizedDescription))
    }

    @Test
    func addCitySuccess() {
        viewModel.addCity("Tokyo")
        #expect(viewModel.status == .loaded)
        #expect(viewModel.cities.count == 3)
        #expect(viewModel.cities.contains(where: { $0.cityName == "Tokyo" }))
    }
    
    @Test
    func addCityFailure() {
        mockRepo.errorToThrow = CustomErrors.saveFailed
        viewModel.addCity("Tokyo")
        #expect(viewModel.status == .error(CustomErrors.saveFailed.localizedDescription))
    }

    @Test
    func deleteCitySuccess() {
        viewModel.fetchCities()
        let cityToDelete = viewModel.cities.first { $0.cityName == "Delhi" }
        viewModel.deleteCity(cityToDelete!)

        #expect(viewModel.status == .loaded)
        #expect(viewModel.cities.count == 1)
        #expect(!viewModel.cities.contains(where: { $0.cityName == "Delhi" }))
    }
    
    @Test
    func deleteCityFailure() {
        viewModel.fetchCities()
        let cityToDelete = City(cityName: "Goa")
        viewModel.deleteCity(cityToDelete)

        #expect(viewModel.cities.count == 2)
        #expect(viewModel.status == .error(CustomErrors.deleteFailed.localizedDescription))
    }
}
