//
//  City.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation
import SwiftUI

struct City {
    let name: String
    
    let weatherCondition: String
    let description: String
    let icon: Image
    let currentTemperatures: Int
    let feelsTemperatures: Int
    let currentHumidity: Int
    let minimumTemperatures: Int
    let maximumTemperatures: Int
    let pressure: Int
    let windSpeed: Int
    var cityName: String
}
