//
//  WeatherLandingView.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 23/07/25.
//

import SwiftUI

struct WeatherLandingView: View {
    @StateObject var viewModel: WeatherLandingViewModel
    @State var shouldAddCity: Bool = false
    @State var presentAddCityView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.cities.isEmpty {
                    EmptyWeatherView(shouldAddCity: $shouldAddCity)
                        .onChange(of: shouldAddCity) { _, newValue in
                            if newValue {
                                handleAddCity()
                                shouldAddCity = false
                            }
                        }
                } else {
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
            }
            .addLinearGradientBackground()
            .onAppear {
                viewModel.fetchCities()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        handleAddCity()
                    } label: {
                        Image(systemName: ImageConstants.plus)
                    }
                }
            }
            .fullScreenCover(isPresented: $presentAddCityView) {
                AddCityView(viewModel: viewModel)
            }
            
        }
    }
    
    private func handleAddCity() {
        presentAddCityView = true
    }
}

struct WeatherLandingView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherLandingView(viewModel: WeatherLandingViewModel.preview)
    }
}
