//
//  Constants.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 24/07/25.
//

struct ImageConstants {
    static let plus = "plus"
    static let humidity = "humidity"
    static let barometer = "barometer"
    static let wind = "wind"
    static let viewer = "viewer"
    static let chevronRight = "chevron.right"
    static let exclamationTriangle = "exclamationmark.triangle.fill"
}

struct AppConstants {
    //Air Visual API Key
    static let weatherAPIKey = "weather_api_key"
    static let openWeatherBaseURL = "https://api.openweathermap.org/data/2.5/forecast"
    static let airVisualKey = "b9f2d98a-d2bc-44d0-b41c-cb9d81d16b62"

    static func getIconURL(for icon: String) -> String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}
