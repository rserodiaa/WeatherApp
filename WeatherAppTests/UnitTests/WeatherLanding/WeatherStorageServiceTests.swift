//
//  WeatherStorageServiceTests.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 02/08/25.
//

@testable import WeatherApp
import Testing
import CoreData

@Suite
struct WeatherStorageServiceTests {

    var mockContext: NSManagedObjectContext
    var storageService: WeatherStorageServiceProtocol

    init() throws {
        let mockContainer = NSPersistentContainer(name: "WeatherApp")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        mockContainer.persistentStoreDescriptions = [description]

        var loadError: Error?
        mockContainer.loadPersistentStores { _, error in
            loadError = error
        }

        if let error = loadError {
            throw error
        }

        mockContext = mockContainer.viewContext
        storageService = WeatherStorageService(context: mockContext)
    }

    @Test("Test creating and fetching a city to in memory core data")
    func createAndFetchCity() throws {
        let city = City(cityName: "Tokyo")

        try storageService.create(city: city)
        let cities = try storageService.fetchCities()

        #expect(cities.count == 1)
        #expect(cities.first?.cityName == "Tokyo")
    }

    @Test("Test deleting a city from in memory core data")
    func deleteCity() throws {
        let city = City(cityName: "Paris")

        try storageService.create(city: city)
        try storageService.delete(city: city)

        let cities = try storageService.fetchCities()
        #expect(cities.isEmpty)
    }

    @Test("Test deleting a non-existent city from in memory core data")
    func deleteNonExistentCity() throws {
        let city = City(cityName: "Nonexistent")
        try storageService.delete(city: city)
        let cities = try storageService.fetchCities()
        #expect(cities.isEmpty)
    }
}
