//
//  Repository.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation
import Combine

class WeatherRepository: ObservableObject {
    private let apiProvider = APIProvider()
    
    func fetchWeatherData(of city: City) -> AnyPublisher<CityWeather, WeatherError> {
        guard let geoInfo = UserDefaults.standard.object(forKey: city.rawValue) as? GeoInfo else {
            fatalError("Couldn't find GeoInfo in UserDefaults.")
        }
        let request = WeatherInfoRequest(cityGeoInfo: geoInfo)
        return self.apiProvider.request(requestType: request)
            .map{ data in
                data.domain(of: city)
            }
            .eraseToAnyPublisher()
    }
}
