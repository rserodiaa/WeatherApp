//
//  WeatherLandingView.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 23/07/25.
//

import SwiftUI

struct WeatherHome: View {
    @StateObject var viewModel: WeatherLandingViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView {
                    ForEach(viewModel.cities) { city in
                        Text(city.cityName)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))

                .navigationBarItems(
                      trailing: Button(action: {}, label: {
                          NavigationLink(destination: AllCitiesList(viewModel: viewModel)) {
                             Image(systemName: "plus").foregroundColor(.black)
                         }
                      }))
            }
            .addLinearGradient().ignoresSafeArea()
        }
        
    }
}

struct WeatherHome_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHome(viewModel: WeatherLandingViewModel.preview)
    }
}
