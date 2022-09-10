//
//  APIRequest.swift
//  TodaysWeather
//
//  Created by 서녕 on 2022/06/10.
//

import Foundation

protocol APIRequest {
    associatedtype ResponseType: Decodable
    
    var component: URLComponents { get }
    var urlRequest: URLRequest? { get }
}

struct RequestComponent {
    static let shared = RequestComponent()
    
    let scheme = "https"
    let host = "api.openweathermap.org"
    let weatherPath = "/data/2.5/weather"
    let geoPath = "/geo.1.0/direct"
    let key = Bundle.main.openWeatherAPIKey
    let language = "kr"
    
    
    func makeWeatherComponents(with geoInfo: GeoInfo) -> URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.weatherPath
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: geoInfo.latitude),
            URLQueryItem(name: "lon", value: geoInfo.longitude),
            URLQueryItem(name: "appid", value: self.key),
            URLQueryItem(name: "lang", value: self.language)
        ]
        
        return components
    }
    
    func makeGeoComponents(with city: City) -> URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.geoPath
        
        components.queryItems = [
            URLQueryItem(name: "q", value: "\(city),\(self.language)"),
            URLQueryItem(name: "appid", value: self.key),
            URLQueryItem(name: "litmit", value: "1")
        ]
        
        return components
    }
}
