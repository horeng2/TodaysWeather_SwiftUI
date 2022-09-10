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
    
    private func loadWeatherData(of city: City) async throws -> AnyPublisher<ResponseWeatherData, Never> {
        do {
            guard let geoInfo = UserDefaults.standard.object(forKey: city.rawValue) as? GeoInfo else {
                fatalError("Couldn't find GeoInfo in UserDefaults.")
            }
            let request = WeatherInfoRequest(cityGeoInfo: geoInfo)
            let responseData = try await self.apiProvider.request(requestType: request)
            return decode(responseData)
        } catch {
            print(error)
            return Empty().eraseToAnyPublisher()
        }
    }
}
