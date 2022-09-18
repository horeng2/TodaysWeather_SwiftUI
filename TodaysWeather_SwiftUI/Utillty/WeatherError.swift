//
//  WeatherError.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/09.
//

import Foundation

enum WeatherError: Error {
    case responseError
    case createUrlError
    case parsingError
}
