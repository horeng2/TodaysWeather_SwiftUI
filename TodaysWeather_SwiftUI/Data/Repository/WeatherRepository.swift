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
    
    func fetchWeatherData(of city: City) -> AnyPublisher<ResponseWeatherData, WeatherError> {
        let request = WeatherInfoRequest(city: city)
        return self.apiProvider.request(requestType: request)
            .eraseToAnyPublisher()
    }
}
