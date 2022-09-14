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
    let iconURL: String
    let currentTemperatures: Int
    let feelsTemperatures: Int
    let currentHumidity: Int
    let pressure: Int
    let windSpeed: Int
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
                weatherCondition: "clear",
                iconURL: "http://openweathermap.org/img/wn/10d@2x.png",
                currentTemperatures: 22,
                feelsTemperatures: 20,
                currentHumidity: 50,
                pressure: 1055,
                windSpeed: 5),
        CityWeather(cityName: "Busan",
                weatherCondition: "snow",
                iconURL: "http://openweathermap.org/img/wn/11d@2x.png",
                currentTemperatures: 25,
                feelsTemperatures: 23,
                currentHumidity: 40,
                pressure: 999,
                windSpeed: 10)
    ]
}
