//
//  APIRequest.swift
//  TodaysWeather
//
//  Created by 서녕 on 2022/06/10.
//

import Foundation

protocol APIRequest {
    associatedtype ResponseType: Decodable
    
    var url: URL? { get }
    var urlRequest: URLRequest? { get }
}
