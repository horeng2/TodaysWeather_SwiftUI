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
    let weatherCondition: String
    let description: String
    let iconURL: String
    let currentTemperatures: Int
    let feelsTemperatures: Int
    let currentHumidity: Int
    let pressure: Int
    let windSpeed: Double
}

enum WeatherConditionType {
    case clear
    case cloudy
    case overcast
    case rain
    case snow
    case unknown
}

enum ImageURL {
    case icon
    
    func url(key: String) -> String {
        switch self {
        case .icon:
            return "http://openweathermap.org/img/wn/\(key)@2x.png"
        }
    }
}

enum TemperatureUnit {
    case humidity
    case celsius
    case fahrenheit
    case windSpeed
    case pressure

    var symbol: String {
        switch self {
        case .humidity:
            return "%"
        case .celsius:
            return "ºC"
        case .fahrenheit:
            return "ºF"
        case .windSpeed:
            return "m/s"
        case .pressure:
            return "hPa"
        }
    }
}

extension CityWeather {
    static let mockData: [CityWeather] = [
        CityWeather(cityName: "Gumi",
                weatherCondition: "맑음",
                description: "맑아요",
                iconURL: "http://openweathermap.org/img/wn/10d@2x.png",
                currentTemperatures: 1,
                feelsTemperatures: 2,
                currentHumidity: 3,
                pressure: 4,
                windSpeed: 5),
        CityWeather(cityName: "Gwangju",
                weatherCondition: "흐림",
                description: "흐려요",
                iconURL: "http://openweathermap.org/img/wn/11d@2x.png",
                currentTemperatures: 6,
                feelsTemperatures: 7,
                currentHumidity: 8,
                pressure: 9,
                windSpeed: 10)
    ]
}
