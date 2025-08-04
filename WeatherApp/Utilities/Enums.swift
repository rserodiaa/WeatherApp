//
//  Enums.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 24/07/25.
//

import Foundation

enum LoadingState: Equatable {
    case loading
    case loaded
    case idle
    case error(String)
}

enum CustomErrors: LocalizedError, Equatable {
    case fetchFailed
    case deleteFailed
    case saveFailed
    case apiError(String)

    var errorDescription: String? {
        switch self {
        case .fetchFailed:
            return "Could not fetch Cities. Please try again."
        case .deleteFailed:
            return "Could not delete the City."
        case .saveFailed:
            return "Could not save your City. Please try again."
        case .apiError(let message):
            return "AQI API Error: \(message)"
        }
    }
}
