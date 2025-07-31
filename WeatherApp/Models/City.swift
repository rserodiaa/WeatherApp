//
//  City.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 23/07/25.
//

import Foundation

struct City: Identifiable {
    let id: UUID
    let cityName: String
    let createdOn: Date
    
    init(id: UUID = UUID(), cityName: String, createdOn: Date = Date()) {
        self.id = id
        self.cityName = cityName
        self.createdOn = createdOn
    }
    
    init(from entity: CDCity) {
        self.init(id: entity.id!,
                  cityName: entity.cityName ?? "",
                  createdOn: entity.createdOn ?? Date())
    }
}
