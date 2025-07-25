//
//  WeatherLandingView.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 23/07/25.
//

import SwiftUI

struct WeatherLandingView: View {
    @StateObject var viewModel: WeatherLandingViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                TabView {
                    ForEach(viewModel.cities) { city in
                        CityOverview(city: city.cityName, viewModel: CityOverviewViewModel(weatherService: WeatherService()))
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
            .addLinearGradientBackground()
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        //Action
                    } label: {
                        Image(systemName: ImageConstants.plus)
                    }
                }
            }
            
        }
    }
}

struct WeatherLandingView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherLandingView(viewModel: WeatherLandingViewModel.preview)
    }
}
