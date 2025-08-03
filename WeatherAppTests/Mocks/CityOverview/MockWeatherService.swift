//
//  MockWeatherService.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 03/08/25.
//

@testable import WeatherApp
import Combine
import Foundation

final class MockWeatherService: WeatherServiceProtocol {
    
    var error: Error?
    var sampleWeather: Weather = MockWeatherUtils.loadSampleWeather()
    
    func fetchWeatherData(for city: String) -> AnyPublisher<Weather, Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(sampleWeather)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    //To be implemented later..
    func fetchPollutionData(lat: Double, lon: Double) -> AnyPublisher<PollutionData, Error> {
        Fail(error: URLError(.unsupportedURL)).eraseToAnyPublisher()
    }
    
    func fetchPollutionDetails(lat: Double, lon: Double) -> AnyPublisher<PollutionDetails, Error> {
        Fail(error: URLError(.unsupportedURL)).eraseToAnyPublisher()
    }
}
