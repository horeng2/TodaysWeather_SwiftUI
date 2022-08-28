//
//  Weather.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/27.
//

import Foundation
import SwiftUI

struct Weather: Decodable {
    let list: List
    
    struct List: Decodable {
        let main: WeatherDetail
        let weather: [WeatherBasicsInfo]
        let wind: WindCondition
        let dt_txt: String
        
        struct WeatherBasicsInfo: Decodable {
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
            let temp_min: Double
            let temp_max: Double
            let pressure: Double
            let humidity: Double
        }
        
        struct WindCondition: Decodable {
            var speed: Double
        }
    }
}
