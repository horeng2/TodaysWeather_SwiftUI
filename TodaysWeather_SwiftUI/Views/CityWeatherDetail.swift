//
//  CityWeatherDetail.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import SwiftUI

struct CityWeatherDetail: View {
    @EnvironmentObject var repository: Repository
    var cityWeather: CityWeather
    
    var body: some View {
        VStack {
            Text(cityWeather.cityName.rawValue)
                .font(.title)
        }
    }
}

