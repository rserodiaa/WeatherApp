//
//  CityOverviewRepository.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 25/07/25.
//

import Combine

final class CityOverviewRepository: CityOverviewRepositoryProtocol {
    private let service: WeatherServiceProtocol

    init(service: WeatherServiceProtocol) {
        self.service = service
    }

    func fetchWeatherData(for city: String) -> AnyPublisher<Weather, Error> {
        return service.fetchWeatherData(for: city)
    }
}
