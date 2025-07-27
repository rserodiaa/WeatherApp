//
//  CityOverviewRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 25/07/25.
//

import Combine

protocol CityOverviewRepositoryProtocol {
    func fetchWeatherData(for city: String) -> AnyPublisher<Weather, Error>
}
