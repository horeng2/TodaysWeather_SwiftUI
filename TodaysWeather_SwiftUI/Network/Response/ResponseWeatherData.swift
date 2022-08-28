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
    
    private enum CodingKeys: String, CodingKey {
        case weather
        case detail = "main"
        case wind
    }
    
    struct BacisInfo: Decodable {
        let id: Int
        let weatherCondition: String
        let description: String
        let icon: String
        
        private enum CodingKeys: String, CodingKey {
            case id
            case weatherCondition = "main"
            case description
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
