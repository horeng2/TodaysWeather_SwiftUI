//
//  APIProvider.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation

class APIProvider {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: APIRequest>(
        requestType: T,
        completionHandler: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        guard let request = requestType.urlRequest else {
            return
        }
        let task = self.session.dataTask(with: request) { data, urlResponse, error in
            guard let httpResponse = urlResponse as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      return completionHandler(.failure(.responseError))
            }
            guard let data = data else {
                return completionHandler(.failure(.invaildData))
            }
            completionHandler(.success(data))
        }
        task.resume()
    }
}
