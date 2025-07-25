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
    @Published var isLoaded = false
    @Published var iconURL: URL = URL(string: AppConstants.getIconURL(for: "10d"))!
    @Published var desc: String = ""
    @Published var currentTemp: Int = 0
    @Published var humidity = ""
    @Published var wind = ""
    @Published var visibility = ""
    @Published var pressure = ""
    
    private let weatherService: WeatherServiceProtocol
    private var cancellable = Set<AnyCancellable>()
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
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
    
    var latLong: (Double, Double) {
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
        weatherService.fetchWeatherData(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.status = .error(error.localizedDescription)
                case .finished:
                    break
                }
                
            }, receiveValue: { [weak self] data in
                guard let self = self else {
                    return
                }
                self.isLoaded = true
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.weather = data
                    self.iconURL = URL(string: AppConstants.getIconURL(for: self.icon))!
                    self.desc = self.currentList?.weather.first?.description.capitalized ?? ""
                    self.currentTemp = Int(self.currentList?.main.temp ?? 0)
                    self.humidity = "\(self.currentList?.main.humidity ?? 0)%"
                    self.wind = "\(Int(self.currentList?.wind.speed ?? 0)) Km/h"
                    self.visibility = "\((self.currentList?.visibility ?? 0)/1000) Km"
                    self.pressure = "\(self.currentList?.main.pressure ?? 0)"
                    self.status = .loaded
                }
            })
            .store(in: &cancellable)
    }
}
