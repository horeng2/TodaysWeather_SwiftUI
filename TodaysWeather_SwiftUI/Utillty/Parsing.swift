//
//  Parsing.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/09.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Never> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
        fatalError("Couldn't parse \(T.self):\n\(error)")
    }
    .eraseToAnyPublisher()
}
