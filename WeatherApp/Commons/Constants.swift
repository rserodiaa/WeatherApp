//
//  Constants.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 24/07/25.
//

struct ImageConstants {
    static let plus = "plus"
    static let cloudSun = "cloud.sun.fill"
    static let humidity = "humidity"
    static let barometer = "barometer"
    static let wind = "wind"
    static let viewer = "viewer"
    static let chevronRight = "chevron.right"
    static let exclamationTriangle = "exclamationmark.triangle.fill"
    static let happy = "happy"
    static let moderate = "moderate"
    static let bad = "bad"
    static let unhealthy = "unhealthy"
    static let hazardous = "hazardous"
    static let information = "information"
}

struct AppConstants {
    //Air Visual API Key
    static let weatherAPIKey = "weather_api_key"
    static let airVisualAPIKey = "airvisual_api_key"
    static let airVisualKey = "b9f2d98a-d2bc-44d0-b41c-cb9d81d16b62"

    static func getIconURL(for icon: String = "10d") -> String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}
