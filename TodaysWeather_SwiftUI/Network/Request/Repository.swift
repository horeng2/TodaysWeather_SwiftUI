//
//  Repository.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation

class Repository {
    private let apiProvider = APIProvider()
    
    
    func loadCityWeathers() -> [CityWeather] {
        var cityWeathers = [CityWeather]()
        
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
                cityWeathers.append(weather)
            }
        }
        
        return cityWeathers
    }
    
    private func loadWeatherData(of city: City,
                         completionHandler: @escaping (ResponseWeatherData) -> Void) {
        self.loadGeoInfo(of: city) { geoInfo in
            self.apiProvider.request(requestType: WeatherInfoRequest(cityGeoInfo: geoInfo)) { (result: Result<Data, NetworkError>) in
                switch result {
                case .success(let data):
                    completionHandler(self.decode(of: data))
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func loadGeoInfo(of city: City,
                     completionHandler: @escaping (GeoInfo) -> Void) {
        apiProvider.request(requestType: GeoInfoRequest(city: city)) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                completionHandler(self.decode(of: data))
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func decode<T: Decodable>(of data: Data) -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(T.self):\n\(error)")
        }
    }
}
