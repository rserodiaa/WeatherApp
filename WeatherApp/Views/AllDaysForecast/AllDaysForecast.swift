//
//  AllDaysForecast.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import SwiftUI

struct AllDaysForecast: View {
    @Environment(\.presentationMode) var presentationMode
    var cityViewModel: CityOverviewViewModel
    //change
    @StateObject var viewModel = PollutionViewModel(repository: PollutionRepository(service: WeatherService()))
    
    var body: some View {
        
        //MARK: Body
        ScrollView {
            navigationBar
            heading
            Spacer().frame(height: 30)
            
            dailyWidget
            Spacer().frame(height: 30)
            
            if viewModel.isLoaded && viewModel.isDetailsLoaded {
                PollutionToggleWidget(aqiLevel: viewModel.aqiLevel,
                                      pollutionComps: viewModel.pollutionComponents)
            } else {
                ProgressView()
            }
            
        }
        .onAppear(perform: fetchPollutionData)
        .navigationBarHidden(true)
        .addLinearGradientBackground()
    }
    
    
    //MARK: Widgets
    private var navigationBar: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
                Spacer()
            }
        }
        .foregroundColor(.primary)
        .padding()
    }
    
    private var heading: some View {
        Text("\(cityViewModel.weather?.city.name ?? ""), \(cityViewModel.weather?.city.country ?? "")")
            .fontWeight(.bold)
            .font(.system(size: 30))
    }
    
    private var dailyWidget: some View {
        VStack {
            if let daily = cityViewModel.dailyForecast {
                ForEach(daily, id: \.dt) { data in
                    let date = cityViewModel.formattedDate(from: data.dtTxt)
                    let icon = data.weather.first?.icon ?? "01n"
                    let iconUrl = URL(string: AppConstants.getIconURL(for: icon))
                    DailyRow(imageName: iconUrl,
                             temp: Int(data.main.temp),
                             day: date.day,
                             date: date.date)
                }
            }
            Spacer()
        }
        .padding()
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 40).fill(.purple.opacity(0.75)))
        .padding(.horizontal, 25)
    }
    
    private func fetchPollutionData() {
        if viewModel.pollutionData == nil {
            viewModel.getPollutionData(lat: cityViewModel.latLong.0,
                                         lon: cityViewModel.latLong.1)
        }
    }
}
