//
//  OpenWeatherAPIProvider.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation
import Combine

class APIProvider {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: APIRequest>(requestType: T) -> AnyPublisher<T.ResponseType, WeatherError> {
        guard let request = requestType.urlRequest else {
            return Fail(error: WeatherError.createUrlError).eraseToAnyPublisher()
        }
        
        return self.session
            .dataTaskPublisher(for: request)
            .mapError{ error in
                    .responseError
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}


