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
    @Published var pollutionDetails: PollutionDetails?
    @Published var status: LoadingState = .idle
    
    private let requiredComps: Set<String> = ["pm2_5", "so2", "co", "pm10", "o3", "no2"]
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
        status = .loading
        var dataReceived = false
        var detailsReceived = false
        
        repository.fetchPollutionData(for: lat, and: lon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    status = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] data in
                guard let self = self else { return }
                pollutionData = data
                dataReceived = true
                checkAndSetLoaded(dataReceived: dataReceived, detailsReceived: detailsReceived)
            })
            .store(in: &cancellable)
        
        repository.fetchPollutionDetails(for: lat, and: lon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    status = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] details in
                guard let self = self else { return }
                pollutionDetails = details
                detailsReceived = true
                checkAndSetLoaded(dataReceived: dataReceived, detailsReceived: detailsReceived)
            })
            .store(in: &cancellable)
    }
    
    private func checkAndSetLoaded(dataReceived: Bool, detailsReceived: Bool) {
        if dataReceived && detailsReceived {
            status = .loaded
        }
    }
}
