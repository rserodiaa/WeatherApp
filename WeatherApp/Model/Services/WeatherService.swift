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
    /// - Returns: Returns publisher and decode into model ``WeatherData``
    func fetchWeatherData(for city: String) -> AnyPublisher<Weather, Error> {
        guard let apiKey = KeychainHelper.shared.read(forKey: AppConstants.weatherAPIKey) else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }
        // TODO refactor url builder
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric")
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
    
    /*
    static func getPollutionData(lat: Double, lon: Double) -> AnyPublisher<PollutionData, Error> {
        guard let url = URL(string: "https://api.airvisual.com/v2/nearest_city?lat=\(lat)&lon=\(lon)&key=\(AppConstants.airVisualKey)")
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
    
    static func getPollutionDetails(lat: Double, lon: Double) -> AnyPublisher<PollutionDetails, Error> {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(AppConstants.apiKey)")
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
     */
}
