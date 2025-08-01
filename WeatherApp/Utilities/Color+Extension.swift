//
//  Color+Extension.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 23/07/25.
//
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static let offWhite = Color(hex: 0xFAF9F6)
    static let paleYellow = Color(hex: 0xEABDE6)
    static let primaryColor = Color(hex: 0xAA60C8)
    static let darkPurpleColor = Color(hex: 0x7F55B1)
}
