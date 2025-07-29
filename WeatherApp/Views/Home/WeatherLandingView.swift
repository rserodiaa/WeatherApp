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
                        CityOverview(city: city.cityName, viewModel: CityOverviewViewModel(repository: CityOverviewRepository(service: WeatherService())))
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .onAppear {
                    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.primaryColor)
                    
                    UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.gray.opacity(0.5))
                }
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
