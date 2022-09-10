//
//  GeoInfoFetcher.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/10.
//

import Foundation
import Combine

class GeoInfoFetcher {
    let repository: GeoInfoRepository
    var cancelBag = Set<AnyCancellable>()
    
    init(repository: GeoInfoRepository) {
        self.repository = repository
    }
    
    func saveGeoInfo() {
        for city in City.allCases {
            self.repository.fetchGeoInfo(of: city)
                .sink(receiveCompletion: { value in
                    switch value {
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { geoInfo in
                    UserDefaults.standard.set(geoInfo, forKey: city.rawValue)
                })
                .store(in: &self.cancelBag)
        }
    }
}
