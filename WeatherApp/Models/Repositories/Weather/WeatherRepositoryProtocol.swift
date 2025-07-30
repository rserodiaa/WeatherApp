//
//  WeatherRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 25/07/25.
//

protocol WeatherRepositoryProtocol {
    func create(city: City) throws
    func fetchCities() throws -> [City]
    func delete(city: City) throws
}
