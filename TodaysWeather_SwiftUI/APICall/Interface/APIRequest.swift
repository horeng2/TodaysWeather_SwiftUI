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
    let path = "/data/2.5/weather"
    let key = Bundle.main.openWeatherAPIKey
    let language = "kr"
    
    
    func makeWeatherComponents(with city: City) -> URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city.rawValue),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: self.key),
            URLQueryItem(name: "lang", value: self.language)
        ]
        
        return components
    }
}
