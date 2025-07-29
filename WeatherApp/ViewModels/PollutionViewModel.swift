//
//  PollutionViewModel.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import SwiftUI
import Combine

final class PollutionViewModel: ObservableObject {
    @Published var pollutionData: PollutionData?
    @Published var isLoaded = false
    @Published var isDetailsLoaded = false
    @Published var pollutionDetails: PollutionDetails?
    private let requiredComps = ["pm2_5","so2", "co", "pm10", "o3", "no2"]
    private let repository: PollutionRepositoryProtocol
    private var cancellable = Set<AnyCancellable>()
    
    init(repository: PollutionRepositoryProtocol) {
        self.repository = repository
    }
    
    var aqiLevel: Int {
        pollutionData?.data.current.pollution.aqius ?? 0
    }
    
    private var allComps: [String: Double]? {
        pollutionDetails?.list.first?.components
    }
    
    var pollutionComponents: [String: Double]? {
        allComps?.filter { requiredComps.contains($0.key) }
    }
    
    func getPollutionData(lat: Double, lon: Double) {
        getPollutionDetails(lat: lat, lon: lon)
        repository.fetchPollutionData(for: lat, and: lon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    return
                }
                
            }, receiveValue: { [weak self] data in
                guard let self = self else { return }
                isLoaded = true
                pollutionData = data
            })
            .store(in: &cancellable)
    }
    
    func getPollutionDetails(lat: Double, lon: Double) {
        repository.fetchPollutionDetails(for: lat, and: lon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    return
                }
                
            }, receiveValue: { [weak self] data in
                guard let self = self else { return }
                isDetailsLoaded = true
                pollutionDetails = data
            })
            .store(in: &cancellable)
    }
}
