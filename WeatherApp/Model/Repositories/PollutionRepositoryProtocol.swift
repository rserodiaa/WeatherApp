//
//  PollutionRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import Combine

protocol PollutionRepositoryProtocol {
    func fetchPollutionData(for lat: Double, and lon: Double) -> AnyPublisher<PollutionData, Error>
    func fetchPollutionDetails(for lat: Double, and lon: Double) -> AnyPublisher<PollutionDetails, Error>
}
