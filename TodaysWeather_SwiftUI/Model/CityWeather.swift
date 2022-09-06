//
//  CityWeather.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation
import SwiftUI

struct CityWeather: Hashable {
    let cityName: City
    let isFavorite = false
    
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
