//
//  WeatherRepositoryTests.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 02/08/25.
//

import Testing
@testable import WeatherApp

@Suite
struct WeatherRepositoryTests {
    var mockStorage: MockWeatherStorageService
    let repository: WeatherRepositoryProtocol
    
    init() {
        mockStorage = MockWeatherStorageService()
        mockStorage.citiesToReturn =  [
                City(cityName: "Delhi"),
                City(cityName: "Gurugram")
            ]
        repository = WeatherRepository(storageService: mockStorage)
    }
    
    @Test
    func fetchCitiesSuccess() {
        var result: [City] = []
        #expect(throws: Never.self) {
            result = try repository.fetchCities()
        }
        
        #expect(result.count == 2)
        #expect(result.first?.cityName == "Delhi")
    }

    @Test
    func fetchCitiesFailure() {
        mockStorage.errorToThrow = CustomErrors.fetchFailed
        #expect(throws: CustomErrors.fetchFailed) {
            _ = try repository.fetchCities()
        }
    }

    @Test
    func createCitySuccess() {
        var result: [City] = []
        #expect(throws: Never.self) {
            try repository.create(city: City(cityName: "London"))
            result = try repository.fetchCities()
        }

        #expect(result.count == 3)
        #expect(result.last?.cityName == "London")
    }

    @Test
    func createCityFailure() {
        mockStorage.errorToThrow = CustomErrors.saveFailed
        #expect(throws: CustomErrors.saveFailed) {
            try repository .create(city: City(cityName: "London"))
        }
    }

    @Test
    func deleteCitySuccess() {
        var cities: [City] = []
        #expect(throws: Never.self) {
            cities = try repository.fetchCities()
            
            let cityToDelete = cities.first { $0.cityName == "Delhi" }
            try repository.delete(city: cityToDelete!)
            cities = try repository.fetchCities()
        }

        #expect(cities.count == 1)
        #expect(cities.contains { $0.cityName == "Delhi" } == false)
    }

    @Test
    func deleteCityFailure() {
        let city = City(cityName: "Rome")

        #expect(throws: CustomErrors.deleteFailed) {
            try repository.delete(city: city)
        }
    }
}
