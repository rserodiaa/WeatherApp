//
//  CustomErrors.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 30/07/25.
//

import Foundation

enum CustomErrors: LocalizedError {
    case fetchFailed
    case deleteFailed
    case notFound
    case saveFailed

    var errorDescription: String? {
        switch self {
        case .fetchFailed:
            return "Could not fetch Cities. Please try again."
        case .deleteFailed:
            return "Could not delete the City."
        case .saveFailed:
            return "Could not save your City. Please try again."
        case .notFound:
            return "City not found."
        }
    }
}
