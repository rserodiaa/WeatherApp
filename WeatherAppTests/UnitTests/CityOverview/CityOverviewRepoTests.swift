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
    
    @Test("Repository returns weather data on success")
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
        
        #expect(receivedWeather?.city.name == "Gurugram")
        #expect(!(receivedWeather?.list.isEmpty ?? true))
        #expect(receivedError == nil)
    }

    @Test("Repository returns error on failure")
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
