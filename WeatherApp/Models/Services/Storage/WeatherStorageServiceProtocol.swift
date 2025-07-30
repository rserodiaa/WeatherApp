//
//  WeatherStorageServiceProtocol.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 30/07/25.
//

protocol WeatherStorageServiceProtocol {
    func fetchCities() throws -> [City]
    func create(city: City) throws
    func delete(city: City) throws
}
