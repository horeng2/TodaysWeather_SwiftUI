//
//  CityWeather.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation
import SwiftUI

struct CityWeather {
    let cityName: String
    let weatherCondition: WeatherCondition
    var currentTemperatures: String
    var feelsTemperatures: String
    var humidity: String
    var pressure: String
    var windSpeed: String
}

enum TemperatureUnit {
    case humidity
    case celsius
    case windSpeed
    case pressure

    var symbol: String {
        switch self {
        case .humidity:
            return "%"
        case .celsius:
            return "ºC"
        case .windSpeed:
            return "m/s"
        case .pressure:
            return "hPa"
        }
    }
}

extension CityWeather {
    static let mockData: [CityWeather] = [
        CityWeather(cityName: "Gongju",
                    weatherCondition: .clear,
                    currentTemperatures: "22",
                    feelsTemperatures: "20",
                    humidity: "50",
                    pressure: "1055",
                    windSpeed: "5"),
        CityWeather(cityName: "Busan",
                    weatherCondition: .snow,
                    currentTemperatures: "25",
                    feelsTemperatures: "23",
                    humidity: "40",
                    pressure: "999",
                    windSpeed: "10")
    ]
}
