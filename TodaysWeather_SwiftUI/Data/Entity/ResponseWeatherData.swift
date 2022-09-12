//
//  WeatherData.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/27.
//

import Foundation
import SwiftUI

struct ResponseWeatherData: Decodable {
    let weather: [BacisInfo]
    let detail: WeatherDetail
    let wind: WindCondition
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case weather
        case detail = "main"
        case wind
        case name
    }
    
    struct BacisInfo: Decodable {
        let id: Int
        let icon: String
        
        private enum CodingKeys: String, CodingKey {
            case id
            case icon
        }
    }
    
    struct WeatherDetail: Decodable {
        let temp: Double
        let feels_like: Double
        let pressure: Int
        let humidity: Int
    }

    struct WindCondition: Decodable {
        var speed: Double
    }
}

extension ResponseWeatherData {
    func domain(city: City) -> CityWeather {
        return CityWeather(cityName: city.rawValue,
                           weatherCondition: self.convertWeatherCondition(to: self.weather.first!.id),
                           iconURL: ImageURL.icon.url(key: self.weather.first!.icon),
                           currentTemperatures: self.detail.temp.roundToInt(),
                           feelsTemperatures: self.detail.feels_like.roundToInt(),
                           currentHumidity: self.detail.humidity,
                           pressure: self.detail.pressure,
                           windSpeed: self.wind.speed.roundToInt())
    }
    
    func convertWeatherCondition(to weatherID: Int) -> String {
        let rain = (200...599)
        let snow = (600...699)
        let overcast = (700...799)
        let cloudy = (801...899)
        let clear = 800

        let weatherType: WeatherType = {
            if rain.contains(weatherID) {
                return WeatherType.rain
            } else if snow.contains(weatherID) {
                return WeatherType.snow
            } else if overcast.contains(weatherID) {
                return WeatherType.overcast
            } else if cloudy.contains(weatherID) {
                return WeatherType.cloudy
            } else if clear == weatherID {
                return WeatherType.clear
            } else {
                return WeatherType.unknown
            }
        }()
        return weatherType.rawValue
    }
}
