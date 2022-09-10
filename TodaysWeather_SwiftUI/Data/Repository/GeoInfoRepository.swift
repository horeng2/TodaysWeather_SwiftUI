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
    var cancelBag = Set<AnyCancellable>()

    func fetchGeoInfo(of city: City) async -> AnyPublisher<GeoInfo, Never> {
        do {
            let request = GeoInfoRequest(city: city)
            let responseData = try await self.apiProvider.request(requestType: request)
            return decode(responseData)
        } catch {
            print(error)
            return Empty().eraseToAnyPublisher()
        }
    }
}
