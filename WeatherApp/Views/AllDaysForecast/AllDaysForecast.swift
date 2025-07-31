//
//  AllDaysForecast.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

private struct Constants {
    static let back = "Back"
    static let chevronLeft = "chevron.left"
}

struct AllDaysForecast: View {
    @Environment(\.presentationMode) var presentationMode
    var cityViewModel: CityOverviewViewModel
    @StateObject var viewModel = PollutionViewModel(repository: PollutionRepository(service: WeatherService()))
    
    var body: some View {
        
        //MARK: Body
        ScrollView {
            navigationBar
            heading
            Spacer().frame(height: 30)
            
            DailyWidget(cityViewModel: cityViewModel)
                
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
                Image(systemName: Constants.chevronLeft)
                Text(Constants.back)
                    .font(Font.system(size: 17))
                    .fontWeight(.bold)
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
    
    private func fetchPollutionData() {
        if viewModel.pollutionData == nil {
            viewModel.getPollutionData(lat: cityViewModel.latLong.lat,
                                       lon: cityViewModel.latLong.lon)
        }
    }
}
