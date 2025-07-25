//
//  Enums.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 24/07/25.
//

enum LoadingState: Equatable {
    case loading
    case loaded
    case idle
    case error(String)
}
