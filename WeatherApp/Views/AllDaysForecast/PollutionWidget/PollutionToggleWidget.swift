//
//  PollutionToggleWidget.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import SwiftUI

struct PollutionToggleWidget : View {
    var aqiLevel: Int
    var pollutionComps: [String: Double]?
    @State var flipped = false
    
    var body: some View {
        
        let flipDegrees = flipped ? 180.0 : 0
        
        return VStack {
            Spacer()
            
            ZStack() {
                PollutionAQIView(aqiLevel: aqiLevel)
                    .flipRotate(flipDegrees).opacity(flipped ? 0.0 : 1.0)
                PollutionDetailsView(comps: pollutionComps).flipRotate(-180 + flipDegrees).opacity(flipped ? 1.0 : 0.0)
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.8)) {
                    self.flipped.toggle()
                }
            }
            Spacer()
        }
    }
}


struct PollutionToggleWidget_Previews: PreviewProvider {
    static var previews: some View {
        PollutionToggleWidget(aqiLevel: 70,
                              pollutionComps: ["so2": 63.9, "no2": 128.87, "o3": 1.02, "pm10": 351.46, "co": 3898.62, "pm2_5": 251.35])
    }
}
