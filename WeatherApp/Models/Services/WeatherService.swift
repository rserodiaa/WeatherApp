//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 24/07/25.
//


import Foundation
import Combine

struct WeatherService: WeatherServiceProtocol {
    
    /// To get weather data for city
    /// - Parameter city: String
    /// - Returns: Returns publisher and decode into model ``Weather``
    func fetchWeatherData(for city: String) -> AnyPublisher<Weather, Error> {
        guard let apiKey = KeychainHelper.shared.read(forKey: AppConstants.weatherAPIKey) else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }
        guard let url = URLBuilder.buildForecastURL(for: city, apiKey: apiKey)
        else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    /// To get pollution data like AQI for city using AirVisual API
    /// - Parameters
    ///   - lat: The latitude coordinate of the location
    ///   - lon: The longitude coordinate of the location
    /// - Returns: Returns publisher and decode into model ``PollutionData``
    func fetchPollutionData(lat: Double, lon: Double) -> AnyPublisher<PollutionData, Error> {
        guard let url = URLBuilder.buildPollutionDataURL(for: "\(lat)", and: "\(lon)", apiKey: AppConstants.airVisualKey)
        else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: PollutionData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    /// To get pollution component details like SO2, NO2 for city using OpenWeather API
    /// - Parameters
    ///   - lat: The latitude coordinate of the location
    ///   - lon: The longitude coordinate of the location
    /// - Returns: Returns publisher and decode into model ``PollutionDetails``
    func fetchPollutionDetails(lat: Double, lon: Double) -> AnyPublisher<PollutionDetails, Error> {
        guard let apiKey = KeychainHelper.shared.read(forKey: AppConstants.weatherAPIKey) else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }
        guard let url = URLBuilder.buildPollutionDetailsURL(for: "\(lat)", and: "\(lon)", apiKey: apiKey)
//        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(apiKey)")
        else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: PollutionDetails.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
