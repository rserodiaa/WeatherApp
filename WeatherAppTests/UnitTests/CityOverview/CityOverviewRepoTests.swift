//
//  CityOverviewRepoTests.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 03/08/25.
//

import Testing
import Combine
import Foundation
@testable import WeatherApp

@Suite
final class CityOverviewRepositoryTests {
    
    var receivedWeather: Weather?
    var receivedError: Error?
    var cancellables = Set<AnyCancellable>()
    
    @Test("Test Repository fetch from service returns weather data on success")
    func testFetchWeatherSuccess() async {
        let mockService = MockWeatherService()
        let repo = CityOverviewRepository(service: mockService)

        repo.fetchWeatherData(for: "Gurugram")
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.receivedError = error
                    }
                },
                receiveValue: { weather in
                    self.receivedWeather = weather
                }
            )
            .store(in: &cancellables)
        
        try? await Task.sleep(for: .milliseconds(200))
        
        #expect(receivedWeather?.city.name == "Gurugram", "City name should match")
        #expect(!(receivedWeather?.list.isEmpty ?? true), "Weather list should not be empty")
        #expect(receivedError == nil)
    }

    @Test("Test Repository fetch from service returns error on failure")
    func testFetchWeatherFailure() async {
        let mockService = MockWeatherService()
        mockService.error = URLError(.timedOut)
        let repo = CityOverviewRepository(service: mockService)

        repo.fetchWeatherData(for: "Gurugram")
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.receivedError = error
                    }
                },
                receiveValue: { weather in
                    self.receivedWeather = weather
                }
            )
            .store(in: &cancellables)

        #expect(receivedWeather == nil)
        #expect(receivedError != nil)
        #expect((receivedError as? URLError)?.code == .timedOut)
    }
}
