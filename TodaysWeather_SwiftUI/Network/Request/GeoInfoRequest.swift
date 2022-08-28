//
//  GeoInfoRequest.swift
//  TodaysWeather
//
//  Created by 서녕 on 2022/06/10.
//

import Foundation

struct GeoInfoRequest: APIRequest {
    typealias ResponseType = GeoInfo

    let city: City
    
    var url: URL? {
        URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(city.self),kr&limit=1&appid=\(Bundle.main.openWeatherAPIKey)")
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        return URLRequest(url: url)
    }
}
