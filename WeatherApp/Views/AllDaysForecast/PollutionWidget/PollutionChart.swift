//
//  PollutionChart.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import SwiftUI

private struct Constants {
    static let title = "Pollution Levels"
    static let subtitle = "**As per US AQI"
    static let aqi = "AQI"
    static let pollutionData: [(range: String, level: Int)] = [
        ("0-50", 0),
        ("51-100", 51),
        ("101-150", 101),
        ("151-200", 151),
        ("200+", 201)
    ]
}

struct PollutionChart: View {
    @State private var startAnimation = false
    
    var body: some View {
        
        VStack {
            Text(Constants.title).font(.largeTitle)
            Text(Constants.subtitle).font(.subheadline).fontWeight(.light)
            
                .padding(.bottom, 30)
            ForEach(Array(Constants.pollutionData), id: \.level) { data in
                HStack {
                    Image(PollutionHelper.getPollutionLevel(aqi: data.level).2)
                        .padding(.trailing, 20)
                    Text("\(data.range) \(Constants.aqi)")
                        .fontWeight(.ultraLight)
                    
                    Spacer()
                    Text(PollutionHelper.getPollutionLevel(aqi: data.level).0.rawValue)
                        .font(.title2)
                        .fontWeight(.ultraLight)
                        .padding(.trailing, 8)
                    
                }
                .padding(15)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 40).fill(Color(hex: PollutionHelper.getPollutionLevel(aqi: data.level).1)))
                .padding(.horizontal, 30)
                .opacity(startAnimation ? 1 : 0)
                .offset(CGSize(width: 0, height: startAnimation ? -10 : 0))
                .animation(.easeIn(duration: 1.4), value: startAnimation)
                .onAppear {
                    startAnimation = true
                }
            }
            
        }
    }
}

struct PollutionChart_Previews: PreviewProvider {
    static var previews: some View {
        PollutionChart()
    }
}

