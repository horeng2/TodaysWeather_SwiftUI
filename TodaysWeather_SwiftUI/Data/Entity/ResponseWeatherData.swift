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
        
        private enum CodingKeys: String, CodingKey {
            case id
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
                           currentTemperatures: String(self.detail.temp.roundToInt()),
                           feelsTemperatures: String(self.detail.feels_like.roundToInt()),
                           humidity: String(self.detail.humidity),
                           pressure: String(self.detail.pressure),
                           windSpeed: String(self.wind.speed.roundToInt()))
    }
    
    func convertWeatherCondition(to weatherID: Int) -> WeatherCondition {
        let rain = (200...599)
        let snow = (600...699)
        let overcast = (700...799)
        let cloudy = (801...899)
        let clear = 800

        let weatherType: WeatherCondition = {
            if rain.contains(weatherID) {
                return WeatherCondition.rain
            } else if snow.contains(weatherID) {
                return WeatherCondition.snow
            } else if overcast.contains(weatherID) {
                return WeatherCondition.overcast
            } else if cloudy.contains(weatherID) {
                return WeatherCondition.cloudy
            } else if clear == weatherID {
                return WeatherCondition.clear
            } else {
                return WeatherCondition.unknown
            }
        }()
        return weatherType
    }
}
