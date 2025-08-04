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
            
            SunriseSunsetWidget(sunriseTime: cityViewModel.sunriseTime, sunsetTime: cityViewModel.sunsetTime)
                .frame(maxWidth: .infinity, minHeight: 150)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding(.horizontal, 25)
                .padding(.bottom, 30)
            
            switch viewModel.status {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .error(let message):
                VStack {
                    Image(systemName: ImageConstants.exclamationTriangle)
                        .foregroundColor(.red)
                        .font(.title)
                    Text("Unable to load pollution widget due to error: \(message)")
                        .multilineTextAlignment(.center)
                        .padding()
                }
            case .loaded:
                PollutionToggleWidget(aqiLevel: viewModel.aqiLevel,
                                      pollutionComps: viewModel.pollutionComponents)
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
