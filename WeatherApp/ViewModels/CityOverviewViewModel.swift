//
//  CityOverviewViewModel.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 24/07/25.
//

import Foundation
import Combine

final class CityOverviewViewModel: ObservableObject {
    @Published var status: LoadingState = .idle
    @Published var weather: Weather?
    @Published var iconURL: URL = URL(string: URLBuilder.getIconURL())!
    @Published var desc: String = ""
    @Published var currentTemp: Int = 0
    @Published var humidity = ""
    @Published var wind = ""
    @Published var precipitation = ""
    @Published var pressure = ""
    
    private let repository: CityOverviewRepositoryProtocol
    private var cancellable = Set<AnyCancellable>()
    
    init(repository: CityOverviewRepositoryProtocol) {
        self.repository = repository
    }
    
    private var currentList: WeatherList? {
        weather?.list.first
    }
    
    private var icon: String {
        currentList?.weather.first?.icon ?? "10d"
    }
    
    var currentTime: String {
        return DateFormatter.time.string(from: Date())
    }
    
    var currentDate: String {
        return DateFormatter.homeDate.string(from: Date())
    }
    
    var dailyForecast: [WeatherList]? {
        return weather?.list.enumerated().filter { ($0.offset % 8 == 0) }.map { $0.element }
    }
    
    var latLong: (lat: Double, lon: Double) {
        return (weather?.city.coord.lat ?? 0, weather?.city.coord.lon ?? 0)
    }
    
    func formattedTime(from dateStr: String) -> String {
        guard let date = DateFormatter.serverDate.date(from: dateStr) else { return "" }
        return DateFormatter.time.string(from: date)
    }
    
    func formattedDate(from dateStr: String) -> (day: String, date: String) {
        guard let date = DateFormatter.serverDate.date(from: dateStr) else { return ("", "") }
        let formattedDate = DateFormatter.shortDayDate.string(from: date).split(separator: ",").map { "\($0)" }
        return (formattedDate.first ?? "", formattedDate.last ?? "")
    }
    
    func fetchWeatherData(for city: String) {
        status = .loading
        repository.fetchWeatherData(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.status = .error(error.localizedDescription)
                case .finished:
                    break
                }
                
            }, receiveValue: { [weak self] data in
                guard let self = self else { return }
                weather = data
                iconURL = URL(string: URLBuilder.getIconURL(for: self.icon))!
                desc = self.currentList?.weather.first?.description.capitalized ?? ""
                currentTemp = Int(self.currentList?.main.temp ?? 0)
                humidity = "\(self.currentList?.main.humidity ?? 0)%"
                wind = "\(Int(self.currentList?.wind.speed ?? 0)) Km/h"
                precipitation = "\((self.currentList?.pop ?? 0)*100)%"
                pressure = "\(self.currentList?.main.pressure ?? 0)"
                status = .loaded
            })
            .store(in: &cancellable)
    }
}
