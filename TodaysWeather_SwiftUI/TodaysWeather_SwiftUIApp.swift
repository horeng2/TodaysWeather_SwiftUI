//
//  TodaysWeather_SwiftUIApp.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/27.
//

import SwiftUI

@main
struct TodaysWeather_SwiftUIApp: App {
    init() {
        self.registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            let listViewModel: CityListViewModel = DIContainer.shared.resolve()
            CityList(viewModel: listViewModel)
        }
    }

    private func registerDependencies() {
        DIContainer.shared.register(WeatherRepository())

        let weatherRepository: WeatherRepository = DIContainer.shared.resolve()

        DIContainer.shared.register(WeatherUseCase(repository: weatherRepository))
        let weatherUseCase: WeatherUseCase = DIContainer.shared.resolve()
        
        DIContainer.shared.register(CityListViewModel(weatherUseCase: weatherUseCase))
    }
}
