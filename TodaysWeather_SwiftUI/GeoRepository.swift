//
//  GeoRepository.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/08.
//

import Foundation
import Combine

class GeoRepository: ObservableObject {
    private let apiProvider = APIProvider()
    @Published var cityWeathers = [CityWeather]()
    
    init() {
//        self.loadCityWeathers()
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
    
    private func decodeGeoData(of data: Data) -> GeoInfo {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([GeoInfo].self, from: data).first!
        } catch {
            fatalError("Couldn't parse \(GeoInfo.self):\n\(error)")
        }
    }
}
