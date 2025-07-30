//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 25/07/25.
//

final class WeatherRepository: WeatherRepositoryProtocol {
    private let storageService: WeatherStorageServiceProtocol
    
    init(storageService: WeatherStorageServiceProtocol) {
        self.storageService = storageService
    }
    
    func create(city: City) throws {
        do {
            try storageService.create(city: city)
        } catch {
            throw CustomErrors.saveFailed
        }
    }
    
    func fetchCities() throws -> [City] {
        do {
            return try storageService.fetchCities()
        } catch {
            throw CustomErrors.fetchFailed
        }
    }
    
    func delete(city: City) throws {
        do {
            try storageService.delete(city: city)
        } catch {
            throw CustomErrors.deleteFailed
        }
    }
}
