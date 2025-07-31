//
//  URLBuilder.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import Foundation

private struct Constants {
    private static let openWeatherBaseURL = "https://api.openweathermap.org/data/2.5"
    private static let airVisualBaseURL = "https://api.airvisual.com/v2"
    
    enum Endpoint {
        case forecast
        case pollution
        case airVisualCity
        
        var url: String {
            switch self {
            case .forecast:
                return "\(openWeatherBaseURL)/forecast"
            case .pollution:
                return "\(openWeatherBaseURL)/air_pollution"
            case .airVisualCity:
                return "\(airVisualBaseURL)/nearest_city"
            }
        }
    }
}

struct URLBuilder {

    static func getIconURL(for icon: String = "10d") -> String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
    
    static func buildForecastURL(for city: String, apiKey: String, units: String = "metric") -> URL? {
        var components = URLComponents(string: Constants.Endpoint.forecast.url)
        components?.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: units)
        ]
        return components?.url
    }

    static func buildPollutionDataURL(for lat: String, and lon: String, apiKey: String) -> URL? {
        var components = URLComponents(string: Constants.Endpoint.airVisualCity.url)
        components?.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "key", value: apiKey),
        ]
        return components?.url
    }
    
    static func buildPollutionDetailsURL(for lat: String, and lon: String, apiKey: String) -> URL? {
        var components = URLComponents(string: Constants.Endpoint.pollution.url)
        
        components?.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "appid", value: apiKey),
        ]
        return components?.url
    }
}
