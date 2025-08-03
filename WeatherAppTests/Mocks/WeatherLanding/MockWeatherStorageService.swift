//
//  MockWeatherStorageService.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 02/08/25.
//

@testable import WeatherApp

final class MockWeatherStorageService: WeatherStorageServiceProtocol {
    var citiesToReturn: [City] = []
    var errorToThrow: Error?

    func fetchCities() throws -> [City] {
        if let error = errorToThrow { throw error }
        return citiesToReturn
    }

    func create(city: City) throws {
        if let error = errorToThrow { throw error }
        citiesToReturn.append(city)
    }

    func delete(city: City) throws {
        if !citiesToReturn.contains(where: {$0.id == city.id}) { throw CustomErrors.deleteFailed }
        citiesToReturn.removeAll { $0.id == city.id }
    }
}
