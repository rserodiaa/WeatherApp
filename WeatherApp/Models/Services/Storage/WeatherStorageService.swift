//
//  WeatherStorageService.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 30/07/25.
//

import CoreData

final class WeatherStorageService: WeatherStorageServiceProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func fetchCities() throws -> [City] {
        let request: NSFetchRequest<CDCity> = CDCity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "createdOn", ascending: false)
        ]
        let entities = try context.fetch(request)
        return entities.map { City(from: $0) }
    }
    
    func create(city: City) throws {
        let entity = CDCity(context: self.context)
        entity.id = city.id
        entity.cityName = city.cityName
        entity.createdOn = city.createdOn
        try self.context.save()
    }
    
    func delete(city: City) throws {
        let request: NSFetchRequest<CDCity> = CDCity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", city.id as CVarArg)
        if let entity = try self.context.fetch(request).first {
            self.context.delete(entity)
            try self.context.save()
        }
    }
}
