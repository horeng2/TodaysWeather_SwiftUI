//
//  FetchWeatherUseCase.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/10.
//

import Foundation
import Combine

class FetchWeatherUseCase {
    let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func fetchWeatherInfo(of city: City) -> AnyPublisher<CityWeather, WeatherError> {
        return self.repository.fetchWeatherData(of: city)
    }
}
