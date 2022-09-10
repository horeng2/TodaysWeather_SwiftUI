//
//  GeoInfoFetcher.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/10.
//

import Foundation
import Combine

class GeoInfoRepository: ObservableObject {
    private let apiProvider = APIProvider()
    
    func fetchGeoInfo(of city: City) -> AnyPublisher<GeoInfo, WeatherError> {
        let request = GeoInfoRequest(city: city)
        return self.apiProvider.request(requestType: request)
    }
}
