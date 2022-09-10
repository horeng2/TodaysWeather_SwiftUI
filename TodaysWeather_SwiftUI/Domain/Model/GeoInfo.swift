//
//  GeoInfo.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation

struct GeoInfo: Decodable {
    var latitude: String
    var longitude: String
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
