//
//  WeatherUseCase.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/10.
//

import Foundation
import Combine

class WeatherUseCase {
    let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func fetchWeatherInfo(of city: City) -> AnyPublisher<CityWeather, WeatherError> {
        return self.repository.fetchWeatherData(of: city)
            .map{ data in
                data.domain(city: city)
            }
            .eraseToAnyPublisher()
    }
}
