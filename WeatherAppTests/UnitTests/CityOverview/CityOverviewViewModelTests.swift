//
//  Untitled.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 03/08/25.
//

import Testing
import Combine
import Foundation
@testable import WeatherApp

@Suite
struct CityOverviewViewModelTests {

    @Test("Test weather fetch success")
    func weatherFetchSuccess() async {
        let mockRepo = MockCityOverviewRepository()
        let viewModel = CityOverviewViewModel(repository: mockRepo)

        viewModel.fetchWeatherData(for: "Gurugram")

        try? await Task.sleep(for: .milliseconds(200))

        #expect(viewModel.status == .loaded)
        #expect(viewModel.weather != nil)
        #expect(viewModel.desc == "Light Rain")
        #expect(viewModel.currentTemp == 27)
        #expect(viewModel.humidity == "71%")
        #expect(viewModel.wind == "3 Km/h")
        #expect(viewModel.precipitation == "30.0%")
        #expect(viewModel.pressure == "1002")
    }

    @Test("Test weather fetch failure")
    func testWeatherFetchFailure() async {
        let mockRepo = MockCityOverviewRepository()
        mockRepo.error = URLError(.badServerResponse)

        let viewModel = CityOverviewViewModel(repository: mockRepo)

        viewModel.fetchWeatherData(for: "Zocca")

        try? await Task.sleep(for: .milliseconds(200))
        #expect(viewModel.status == .error("The operation couldn’t be completed. (NSURLErrorDomain error -1011.)"))
        #expect(viewModel.weather == nil)
    }
}
