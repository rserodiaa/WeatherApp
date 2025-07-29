//
//  CityOverview.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 24/07/25.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

private struct Constants {
    static let humidity = "Humidity"
    static let wind = "Wind Speed"
    static let visibility = "Visibility"
    static let pressure = "Pressure"
    static let today = "Today"
    static let more = "More"
    static let defaultIcon = "10d"
}

struct CityOverview: View {
    var city: String
    @StateObject var viewModel: CityOverviewViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            
            switch viewModel.status {
            case .loaded:
                header
                currentWeather
                weatherAttributes
                dailyForcastRow
                Spacer()
                
            case .loading:
                ProgressView()
                
            case .idle:
                EmptyView()
                
            case .error(let message):
                VStack {
                    Image(systemName: ImageConstants.exclamationTriangle)
                        .foregroundColor(.red)
                        .font(.largeTitle)
                    Text("Error: \(message)")
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }

        }.onAppear(perform: fetchWeather)
    }
    
    private func fetchWeather() {
        if viewModel.weather == nil {
            viewModel.fetchWeatherData(for: city)
        }
    }
    
    private var header: some View {
        VStack {
            Text(city).fontWeight(.semibold).font(.title)
            Text(viewModel.currentTime).font(.title3)
        }.foregroundColor(.white)
    }
    
    private var currentWeather: some View {
        VStack(alignment: .center) {
            
            WebImage(url: viewModel.iconURL)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
            Text("\(viewModel.currentTemp)° C")
                .fontWeight(.bold)
                .font(.system(size: 64))
            Text(viewModel.desc).font(.caption)
        }
        .foregroundColor(.white)
        .frame(width: 250, height: 260)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.primaryColor).shadow(radius: 5)
        )
        .overlay(
            Text(viewModel.currentDate)
                .padding(.vertical, 5)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill((.white))
                )
                .offset(y: -12),
            alignment: .top
        )
    }
    
    private var weatherAttributes: some View {
        HStack(spacing: 20) {
            ValueDescriptionView(imageName: ImageConstants.humidity, value: viewModel.humidity, weatherAttr: Constants.humidity)
            ValueDescriptionView(imageName: ImageConstants.wind, value: viewModel.wind, weatherAttr: Constants.wind)
            ValueDescriptionView(imageName: ImageConstants.viewer, value: viewModel.visibility, weatherAttr: Constants.visibility)
            ValueDescriptionView(imageName: ImageConstants.barometer, value: viewModel.pressure, weatherAttr: Constants.pressure)
        }
        .padding()
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 40)
            .fill(Color.offWhite)
            .shadow(radius: 5))
        .padding(.horizontal, 25)
    }
    
    private var dailyForcastRow: some View {
        VStack {
            HStack {
                Text(Constants.today)
                Spacer()
                NavigationLink(destination: AllDaysForecast(cityViewModel: viewModel)) {
                Text(Constants.more)
                    Image(systemName: ImageConstants.chevronRight)
                }
                .tint(.black)
                
            }
            .fontWeight(.bold)
            .padding(.horizontal, 41)
            
            ScrollView(.horizontal) {
                HStack(spacing: 30) {
                    
                    if let weatherData = viewModel.weather {
                        ForEach(weatherData.list.prefix(5), id: \.dt) { data in
                            let icon = data.weather.first?.icon ?? Constants.defaultIcon
                            let iconUrl = AppConstants.getIconURL(for: icon)
                            HourlyBox(time: viewModel.formattedTime(from: data.dtTxt),
                                      iconURL: iconUrl,
                                      temp: Int(data.main.temp))
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 20)
        }
    }
}

//struct CityOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        CityOverview(city: "Gurugram")
//    }
//}
