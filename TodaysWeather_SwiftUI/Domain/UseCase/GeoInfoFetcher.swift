//
//  SaveGeoInfoUseCase.swift
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
    
    func saveGeoInfo() async {
        for city in City.allCases {
            let _ = await self.repository.fetchGeoInfo(of: city)
                .sink(receiveValue: { geoInfo in
                    UserDefaults.standard.set(geoInfo, forKey: city.rawValue)
                })
                .store(in: &self.cancelBag)
        }
    }

}
