//
//  DailyWidget.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

private struct Constants {
    static let defaultIcon = "01n"
    static let chevronRight = "chevron.right"
    static let title = "5-Days Forecasts"
}

struct DailyWidget: View {
    var cityViewModel: CityOverviewViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    if let current = cityViewModel.dailyForecast?.first {
                        Text("Max: \(Int(current.main.tempMax))° Min:\(Int(current.main.tempMin))°")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            HStack {
                Text(Constants.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        if let daily = cityViewModel.dailyForecast {
                            ForEach(Array(daily.enumerated()), id: \.element.dt) { index, data in
                                let date = cityViewModel.formattedDate(from: data.dtTxt)
                                let icon = data.weather.first?.icon ?? Constants.defaultIcon
                                let iconUrl = URL(string: AppConstants.getIconURL(for: icon))
                                
                                DailyForecastCard(
                                    imageName: iconUrl,
                                    temp: Int(data.main.temp),
                                    day: date.day,
                                    date: date.date,
                                    isToday: index == 0
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                }
                Image(systemName: Constants.chevronRight)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))
                
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 20)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.primaryColor.opacity(0.75))
        )
        .padding(.horizontal, 20)
    }
    
    
    private struct DailyForecastCard: View {
        let imageName: URL?
        let temp: Int
        let day: String
        let date: String
        let isToday: Bool
        
        var body: some View {
            VStack(spacing: 4) {
                Text("\(temp)°C")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                WebImage(url: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 35)
                
                Text(day)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(isToday ? .yellow : .white.opacity(0.9))
                Text(date)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(isToday ? .yellow : .white.opacity(0.9))
            }
            .padding(.vertical, 18)
            .frame(width: 65, height: 110)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(isToday ? Color.white.opacity(0.15) : Color.clear)
            )
        }
    }
}
