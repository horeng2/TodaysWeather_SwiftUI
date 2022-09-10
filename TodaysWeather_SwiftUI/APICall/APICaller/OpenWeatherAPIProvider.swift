//
//  OpenWeatherAPIProvider.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation
import Combine

class OpenWeatherAPIProvider {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: APIRequest>(
        requestType: T,
        completionHandler: @escaping (Result<Data, WeatherError>) -> Void
    ) {
        guard let request = requestType.urlRequest else {
            return
        }
        let task = self.session.dataTask(with: request) { data, urlResponse, error in
            guard let httpResponse = urlResponse as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      return completionHandler(.failure(.responseError))
            }
            guard let data = data else {
                return completionHandler(.failure(.invaildData))
            }
            completionHandler(.success(data))
        }
        task.resume()
    }
}

private extension OpenWeatherAPIProvider {
    struct OpenWeatherAPI {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let weatherPath = "/data/2.5/weather"
        static let geoPath = "/geo.1.0/direct"
        static let key = Bundle.main.openWeatherAPIKey
        static let language = "kr"
    }
    
    func makeWeatherComponents(with geoInfo: GeoInfo) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.weatherPath
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: geoInfo.latitude),
            URLQueryItem(name: "lon", value: geoInfo.longitude),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key),
            URLQueryItem(name: "lang", value: OpenWeatherAPI.language)
        ]
        
        return components
    }
    
    func makeGeoComponents(with city: City) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.geoPath
        
        components.queryItems = [
            URLQueryItem(name: "q", value: "\(city),\(OpenWeatherAPI.language)"),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key),
            URLQueryItem(name: "litmit", value: "1")
        ]
        
        return components
    }
}
