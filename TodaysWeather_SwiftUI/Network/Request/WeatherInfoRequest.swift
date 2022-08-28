//
//  WeatherInfoRequest.swift
//  TodaysWeather
//
//  Created by 서녕 on 2022/06/10.
//

import Foundation

struct WeatherInfoRequest: APIRequest {
    typealias ResponseType = WeatherData
        
    let cityGeoInfo: GeoInfo
 
    var url: URL? {
        URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(cityGeoInfo.latitude)&lon=\(cityGeoInfo.longitude)&appid=\(Bundle.main.openWeatherAPIKey)&units=metric&lang=kr")
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        return URLRequest(url: url)
    }
}
