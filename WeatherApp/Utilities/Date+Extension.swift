//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 25/07/25.
//

import Foundation

extension DateFormatter {
    private static func make(with format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }

    static let homeDate = make(with: "EEEE, d MMM")
    static let time = make(with: "hh:mm a")
    static let serverDate = make(with: "YYYY-MM-dd HH:mm:ss")
    static let shortDayDate = make(with: "E, dd MMM")
}
