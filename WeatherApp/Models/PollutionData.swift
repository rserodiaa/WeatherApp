//
//  Pollution.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import Foundation

struct PollutionData: Codable {
    let status: PollutionStatus
    let data: DataClass
}

// MARK: - PollutionStatus mapping as per api https://api-docs.iqair.com/#return-codes
enum PollutionStatus: String, Codable {
    case success
    case callLimitReached = "call_limit_reached"
    case apiKeyExpired = "api_key_expired"
    case incorrectApiKey = "incorrect_api_key"
    case ipLocationFailed = "ip_location_failed"
    case noNearestStation = "no_nearest_station"
    case featureNotAvailable = "feature_not_available"
    case tooManyRequests = "too_many_requests"
    
    var description: String {
        switch self {
        case .success:
            return "Success"
        case .callLimitReached:
            return "Call limit reached"
        case .apiKeyExpired:
            return "API key expired"
        case .incorrectApiKey:
            return "Incorrect API key"
        case .ipLocationFailed:
            return "IP location failed"
        case .noNearestStation:
            return "No nearest station found"
        case .featureNotAvailable:
            return "Feature not available"
        case .tooManyRequests:
            return "Too many requests"
        }
    }
}

struct DataClass: Codable {
    let city, state, country: String
    let location: Location
    let current: Current
}

struct Current: Codable {
    let pollution: Pollution
}

struct Pollution: Codable {
    let ts: String
    let aqius: Int
    let mainus: String
    let aqicn: Int
    let maincn: String
}

struct Location: Codable {
    let type: String
    let coordinates: [Double]
}


// MARK: - PollutionDetails
struct PollutionDetails: Codable {
    let coord: Coord
    let list: [PList]
}

struct PList: Codable {
    let main: Main
    let components: [String: Double]
    let dt: Int
}

struct Main: Codable {
    let aqi: Int
}
