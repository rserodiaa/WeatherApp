//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 24/07/25.
//

import Combine

protocol WeatherServiceProtocol {
    func fetchWeatherData(for city: String) -> AnyPublisher<Weather, Error>
}
