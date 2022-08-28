//
//  NetworkError.swift
//  TodaysWeather
//
//  Created by 서녕 on 2022/06/10.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case invaildData
    case responseError
    case parsingError
    case invaildURL
}
