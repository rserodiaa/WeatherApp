//
//  View+Extension.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 23/07/25.
//

import SwiftUI

extension View {
    func flipRotate(_ degrees : Double) -> some View {
        return rotation3DEffect(Angle(degrees: degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    func addLinearGradientBackground() -> some View {
            background(
                LinearGradient(
                    colors: [
                        Color(hex: 0xCF9FFF),
                        Color(hex: 0xE0B0FF),
                        Color(hex: 0xE6E6FA),
                        .white
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
}
