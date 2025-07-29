//
//  Pollution.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import Foundation

struct PollutionData: Codable {
    let status: String
    let data: DataClass
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
