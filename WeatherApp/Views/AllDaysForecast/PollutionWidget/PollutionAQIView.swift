//
//  PollutionAQIView.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import SwiftUI

struct PollutionAQIView: View {
    var aqiLevel: Int
    @State private var showingPopover = false
    
    var body: some View {
        HStack {
            Image(PollutionHelper.getPollutionLevel(aqi: aqiLevel).2)
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
            Spacer()
            
            VStack {
                Text("\(aqiLevel)").font(.title)
                Text("US AQI").font(.caption).fontWeight(.light)
            }
            
            Text(PollutionHelper.getPollutionLevel(aqi: aqiLevel).0.rawValue)
                .padding(.leading, 8)
                .font(.title2)
                .fontWeight(.light)
        }
        .padding()
        .padding(.vertical, 20)
        .frame(height: 130)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(hex: PollutionHelper.getPollutionLevel(aqi: aqiLevel).1))
            
                .overlay(alignment: .topTrailing, content: {
                    Button(action: {
                        showingPopover = true
                    }) {
                        Image(ImageConstants.information)
                            .resizable()
                            .offset(x: 10, y: -20)
                            .frame(width: 30,
                                   height: 30)
                    }
                    .popover(isPresented: $showingPopover) {
                        PollutionChart()
                    }
                })
        )
        .padding(.horizontal, 25)
    }
}

struct PollutionAQIView_Previews: PreviewProvider {
    static var previews: some View {
        PollutionAQIView(aqiLevel: 70)
    }
}
