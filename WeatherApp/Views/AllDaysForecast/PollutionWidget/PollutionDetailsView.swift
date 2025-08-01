//
//  PollutionDetailsView.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import SwiftUI

struct PollutionDetailsView: View {
    var comps: [String: Double]?
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                
                if let comps = comps {
                    ForEach(comps.sorted(by: >), id: \.key) { key, value in
                        let value = Int(value)
                        let pollutant = PollutionHelper.Pollutants(rawValue: key) ?? .so2
                        VStack {
                            ZStack {
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .foregroundColor(Color(hex: pollutant.getColor(value: value)))
                                    .padding(2)
                                Text("\(value)")
                            }
                            Text(pollutant.value)
                                .font(.caption)
                        }
                    }
                }
            }
            .padding()
            .padding(.vertical, 10)
        }
        .frame(height: 130)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.paleYellow)
                .shadow(radius: 6)
        )
        .padding(.horizontal, 25)
    }
}

struct PollutionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PollutionDetailsView(comps: ["so2": 63.9, "no2": 128.87, "o3": 1.02, "pm10": 351.46, "co": 3898.62, "pm2_5": 251.35])
    }
}
