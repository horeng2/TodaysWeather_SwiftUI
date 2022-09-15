//
//  CityListViewModel.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/10.
//

import Foundation
import Combine

class CityListViewModel: ObservableObject {
    @Published var weatherDataSource = [CityWeather]()
    let weatherUseCase: WeatherUseCase
    var cancelBag = Set<AnyCancellable>()
    
    init(weatherUseCase: WeatherUseCase) {
        self.weatherUseCase = weatherUseCase
    }
    
    func fetchWeatherDataSource() {
        self.weatherDataSource.removeAll()
        City.allCases.forEach{ city in
            weatherUseCase.fetchWeatherInfo(of: city)
                .receive(on: DispatchQueue.main)
                .sink { value in
                    switch value {
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                } receiveValue: { [weak self] weatherInfo in
                    var weather = weatherInfo
                    weather.currentTemperatures = "\(weather.currentTemperatures)" + TemperatureUnit.celsius.symbol
                    weather.feelsTemperatures = "\(weather.feelsTemperatures)" + TemperatureUnit.celsius.symbol
                    weather.humidity = "\(weather.humidity)" + TemperatureUnit.humidity.symbol
                    weather.pressure = "\(weather.pressure)" + TemperatureUnit.pressure.symbol
                    weather.windSpeed = "\(weather.windSpeed)" + TemperatureUnit.windSpeed.symbol

                    self?.weatherDataSource.append(weather)
                }
                .store(in: &cancelBag)
        }
    }
}
