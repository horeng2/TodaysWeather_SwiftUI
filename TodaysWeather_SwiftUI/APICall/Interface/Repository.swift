//
//  Repository.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation
import Combine

class Repository: ObservableObject {
    private let apiProvider = APIProvider()
    @Published var cityWeathers = [CityWeather]()
    
    init() {
        self.loadCityWeathers()
    }
    
    private func loadCityWeathers() {
        City.allCases.forEach { city in
            self.loadWeatherData(of: city) { data in
                let weather = CityWeather(cityName: city,
                                          weatherCondition: data.weather.first!.weatherCondition,
                                          description: data.weather.first!.description,
                                          iconURL: ImageURL.icon.url(key: data.weather.first!.icon),
                                          currentTemperatures: Int(data.detail.temp),
                                          feelsTemperatures: Int(data.detail.feels_like),
                                          currentHumidity: data.detail.humidity,
                                          pressure: data.detail.pressure,
                                          windSpeed: data.wind.speed)
                
                DispatchQueue.main.async {
                    self.cityWeathers.append(weather)
                }
            }
        }
    }
    
    private func loadWeatherData(
        of city: City,
        completionHandler: @escaping (ResponseWeatherData) -> Void
    ) {
        self.loadGeoInfo(of: city) { geoInfo in
            self.apiProvider.request(requestType: WeatherInfoRequest(cityGeoInfo: geoInfo)) { (result: Result<Data, NetworkError>) in
                switch result {
                case .success(let data):
                    completionHandler(self.decodeWeatherData(of: data))
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func loadGeoInfo(
        of city: City,
        completionHandler: @escaping (GeoInfo) -> Void
    ) {
        apiProvider.request(requestType: GeoInfoRequest(city: city)) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                completionHandler(self.decodeGeoData(of: data))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func decodeWeatherData(of data: Data) -> ResponseWeatherData {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(ResponseWeatherData.self, from: data)
        } catch {
            fatalError("Couldn't parse \(ResponseWeatherData.self):\n\(error)")
        }
    }
    
    private func decodeGeoData(of data: Data) -> GeoInfo {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([GeoInfo].self, from: data).first!
        } catch {
            fatalError("Couldn't parse \(GeoInfo.self):\n\(error)")
        }
    }
}
