//
//  CityListViewModel.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/10.
//

import Foundation
import Combine

class CityListViewModel: ObservableObject {
    let weatherUseCase: WeatherUseCase
    var cancelBag = Set<AnyCancellable>()

    @Published var weatherDataSource = [CityWeather]()
    
    init(weatherUseCase: WeatherUseCase) {
        self.weatherUseCase = weatherUseCase
    }
    
    func weather() {
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
                    self?.weatherDataSource.append(weatherInfo)
                }
                .store(in: &cancelBag)
        }
    }
}
