//
//  WeatherInfoRequest.swift
//  TodaysWeather
//
//  Created by 서녕 on 2022/06/10.
//

import Foundation

struct WeatherInfoRequest: APIRequest {
    typealias ResponseType = ResponseWeatherData
        
    let city: City
    
    var component: URLComponents {
        RequestComponent.shared.makeWeatherComponents(with: city)
    }
    
    var urlRequest: URLRequest? {
        guard let url = component.url else {
            return nil
        }
        return URLRequest(url: url)
    }
}
