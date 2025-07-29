//
//  URLBuilder.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import Foundation

struct URLBuilder {

    static func buildForecastURL(for city: String, apiKey: String, units: String = "metric") -> URL? {
        var components = URLComponents(string: AppConstants.openWeatherBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: units)
        ]
        return components?.url
    }
}
