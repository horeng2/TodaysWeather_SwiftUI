//
//  CityRow.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/27.
//

import SwiftUI

struct CityWeatherRow: View {
    var cityWeather: CityWeather
    
    var body: some View {
        HStack {
            Text(cityWeather.cityName.rawValue)
                .font(.title2)
            Spacer()
            
            VStack {
                HStack {
                    Text("온도")
                        .font(.subheadline)
                    Text("\(cityWeather.currentTemperatures)")
                        .font(.subheadline)
                }
                HStack {
                    Text("습도")
                        .font(.subheadline)
                    Text("\(cityWeather.currentHumidity)")
                        .font(.subheadline)
                }
            }
        }
        .padding()
    }
}

struct CityWeatherRow_Previews: PreviewProvider {
    static var cityWeathers = Repository().cityWeathers
    
    static var previews: some View {
        Group {
            CityWeatherRow(cityWeather: cityWeathers[0])
            CityWeatherRow(cityWeather: cityWeathers[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
