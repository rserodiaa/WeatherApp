//
//  City.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 23/07/25.
//

import Foundation

struct City: Identifiable {
    let id = UUID()
    let cityName: String
    let createdOn: Date = Date()
    
    init(cityName: String) {
        self.cityName = cityName
    }
    
    init(from entity: CDCity) {
        self.init(cityName: entity.cityName ?? "")
    }
}
