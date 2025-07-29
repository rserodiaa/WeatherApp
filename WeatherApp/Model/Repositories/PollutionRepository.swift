//
//  PollutionRepository.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import Combine

final class PollutionRepository: PollutionRepositoryProtocol {
    private let service: WeatherServiceProtocol

    init(service: WeatherServiceProtocol) {
        self.service = service
    }
    
    func fetchPollutionData(for lat: Double, and lon: Double) -> AnyPublisher<PollutionData, Error> {
        return service.fetchPollutionData(lat: lat, lon: lon)
    }
    
    func fetchPollutionDetails(for lat: Double, and lon: Double) -> AnyPublisher<PollutionDetails, Error> {
        return service.fetchPollutionDetails(lat: lat, lon: lon)
    }
}

    
