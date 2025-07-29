//
//  PollutionHelper.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

struct PollutionHelper {
    enum PollutionLevels: String {
        case Good, Moderate, Sensitive, Unhealthy, Hazardous
    }
    
    enum Pollutants: String {
        case so2, no2, o3, pm10, co, pm2_5
        
        var value: String {
            switch self {
            case .so2: return "SO2"
            case .no2: return "NO2"
            case .o3: return "O3"
            case .pm10: return "PM10"
            case .pm2_5: return "PM2.5"
            case .co: return "CO"
            }
        }
        
        func getColor(value: Int) -> UInt {
            switch self {
            case .so2: return getSOCode(value)
            case .co: return getCOCode(value)
            case .no2: return getNO2Code(value)
            case .pm10: return getPM10Code(value)
            case .o3: return getO3Code(value)
            case .pm2_5: return getPM2Code(value)
            }
        }
    }
    
    static let colorCodes: [UInt] = [0xa8e05f, 0xfdd64b, 0xff9b57, 0xfe6a69, 0xa97abc]
    
    static func getSOCode(_ value: Int) -> UInt {
        switch value {
        case 0...20: return colorCodes[0]
        case 21...80: return colorCodes[1]
        case 81...250: return colorCodes[2]
        case 251...350: return colorCodes[3]
        default: return colorCodes[4]
        }
    }
    
    static func getPM2Code(_ value: Int) -> UInt {
        switch value {
        case 0...10: return colorCodes[0]
        case 11...25: return colorCodes[1]
        case 26...50: return colorCodes[2]
        case 51...75: return colorCodes[3]
        default: return colorCodes[4]
        }
    }
    
    static func getNO2Code(_ value: Int) -> UInt {
        switch value {
        case 0...40: return colorCodes[0]
        case 41...70: return colorCodes[1]
        case 71...150: return colorCodes[2]
        case 151...200: return colorCodes[3]
        default: return colorCodes[4]
        }
    }
    
    static func getPM10Code(_ value: Int) -> UInt {
        switch value {
        case 0...20: return colorCodes[0]
        case 21...50: return colorCodes[1]
        case 51...100: return colorCodes[2]
        case 101...200: return colorCodes[3]
        default: return colorCodes[4]
        }
    }
    
    static func getO3Code(_ value: Int) -> UInt {
        switch value {
        case 0...60: return colorCodes[0]
        case 61...100: return colorCodes[1]
        case 101...140: return colorCodes[2]
        case 141...180: return colorCodes[3]
        default: return colorCodes[4]
        }
    }
    
    static func getCOCode(_ value: Int) -> UInt {
        switch value {
        case 0...4400: return colorCodes[0]
        case 4401...9400: return colorCodes[1]
        case 9401...12400: return colorCodes[2]
        case 12401...15400: return colorCodes[3]
        default: return colorCodes[4]
        }
    }
    
    
    /// To give color codes and description rating
    ///
    ///     It can map only five levels of AQI with following levels
    ///     0-50 Green(Good)
    ///     51-100 Yellow(Moderate)
    ///     101-150 Orange(Sensitive)
    ///     151-200 Red(Unhealthy)
    ///     201-250 Purple(Hazardous)
    ///
    /// - Parameter aqi: AQI Int value in Int which falls into specific range
    /// - Returns: Returns a topple with ``PollutionLevels``, ``colorCodes`` and image name
    static func getPollutionLevel(aqi: Int) -> (PollutionLevels, UInt, String) {
        switch aqi {
        case 0...50 : return (PollutionLevels.Good, colorCodes[0], "happy") // Green
        case 51...100: return (PollutionLevels.Moderate, colorCodes[1], "moderate") // Yellow
        case 101...150: return (PollutionLevels.Sensitive, colorCodes[2], "unhealthy") // Orange
        case 151...200: return (PollutionLevels.Unhealthy, colorCodes[3], "bad") // Red
        default: return (PollutionLevels.Hazardous, colorCodes[4], "hazardous") // Purple
        }
    }
    
}
