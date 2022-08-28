//
//  ImageURL.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation

enum ImageURL {
    case icon
    
    func url(key: String) -> String {
        switch self {
        case .icon:
            return "http://openweathermap.org/img/wn/\(key)@2x.png"
        }
    }
}
