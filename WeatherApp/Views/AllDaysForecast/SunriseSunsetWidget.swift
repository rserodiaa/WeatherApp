//
//  SunsetWidget.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 04/08/25.
//

import SwiftUI

struct SunriseSunsetWidget: View {
    let sunriseTime: String
    let sunsetTime: String
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x8CCDEB).opacity(0.9),
                                            Color(hex: 0x9B7EBD).opacity(0.8),
                                            Color.darkPurpleColor.opacity(0.9)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Sunrise & Sunset")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack {
                    VStack {
                        Image(systemName: ImageConstants.sunrise)
                            .foregroundColor(.yellow)
                            .font(.title)
                        Text(sunriseTime)
                            .foregroundColor(.white)
                            .font(Font.system(size: 14))
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Image(systemName: ImageConstants.sunset)
                            .foregroundColor(.orange)
                            .font(.title)
                        Text(sunsetTime)
                            .foregroundColor(.white)
                            .font(Font.system(size: 14))
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding()
        }
    }
}

#Preview {
    SunriseSunsetWidget(sunriseTime: "5:00 AM", sunsetTime: "6:30 PM")
        .frame(maxWidth: .infinity, maxHeight: 150)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.horizontal, 25)
        .padding(.bottom, 30)
}
