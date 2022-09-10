//
//  GeoInfoRequest.swift
//  TodaysWeather
//
//  Created by 서녕 on 2022/06/10.
//

import Foundation

struct GeoInfoRequest: APIRequest {
    typealias ResponseType = GeoInfo

    let city: City
    
    var component: URLComponents {
        RequestComponent.shared.makeGeoComponents(with: city)
    }
    
    var urlRequest: URLRequest? {
        guard let url = component.url else {
            return nil
        }
        return URLRequest(url: url)
    }
}
