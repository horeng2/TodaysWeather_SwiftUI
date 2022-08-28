//
//  CityWeather.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation
import SwiftUI

struct CityWeather {
    let cityName: City
    
    let weatherCondition: String
    let description: String
    let iconURL: String
    let currentTemperatures: Int
    let feelsTemperatures: Int
    let currentHumidity: Int
    let pressure: Int
    let windSpeed: Double
}
