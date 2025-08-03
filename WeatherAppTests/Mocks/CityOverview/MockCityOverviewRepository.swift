//
//  MockCityOverviewRepository.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 03/08/25.
//

import Combine
import Foundation
@testable import WeatherApp

final class MockCityOverviewRepository: CityOverviewRepositoryProtocol {
    var error: Error? = nil
    var mockData: Weather = MockCityOverviewRepository.loadSampleWeather()

    func fetchWeatherData(for city: String) -> AnyPublisher<Weather, Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(mockData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }

    private static func loadSampleWeather() -> Weather {
        let bundle = Bundle(for: MockCityOverviewRepository.self)
        guard let url = bundle.url(forResource: "WeatherSample", withExtension: "json") else {
            fatalError("WeatherSample.json not found")
        }
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(Weather.self, from: data)
    }
}
