//
//  EmptyWeatherView.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 30/07/25.
//

import SwiftUI

private struct Constants {
    static let title = "No Cities Added"
    static let subtitle = "Start tracking weather by adding your first city"
    static let buttonTitle = "Add City"
}

struct EmptyWeatherView: View {
    @Binding var shouldAddCity: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: ImageConstants.cloudSun)
                .font(.system(size: 80))
                .foregroundStyle(.white, .yellow)
            
            VStack(spacing: 8) {
                Text(Constants.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text(Constants.subtitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Button(action: {
                shouldAddCity = true
            }) {
                HStack {
                    Image(systemName: ImageConstants.plus)
                    Text(Constants.buttonTitle)
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .background(Color.primaryColor)
                .cornerRadius(25)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .addLinearGradientBackground()
    }
}

#Preview {
    EmptyWeatherView(shouldAddCity: .constant(false))
}
