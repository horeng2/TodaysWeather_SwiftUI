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
            Text("서울")
                .font(.title)
            Image(systemName: "star.fill")
        }
    }
}

struct CityWeatherDetail_Previews: PreviewProvider {
    static let repository = Repository()
    
    static var previews: some View {
        CityWeatherDetail(cityWeather: Repository().cityWeathers[0])
            .environmentObject(repository)
    }
}
