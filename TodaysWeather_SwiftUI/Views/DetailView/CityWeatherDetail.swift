//
//  CityWeatherDetail.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import SwiftUI

struct CityWeatherDetail: View {
    @EnvironmentObject var repository: WeatherRepository
    var cityWeather: CityWeather
    @State var image = UIImage()
    
    var body: some View {
        content
            .onAppear {
                ImageCacheManager.shared.loadImage(url: cityWeather.iconURL)
                self.image = ImageCacheManager.shared.image
            }
    }
    
    var content: some View {
        VStack {
            Image(uiImage: self.image)
            Text(cityWeather.cityName)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(cityWeather.weatherCondition.localize())
                .font(.title2)
                .fontWeight(.bold)

            VStack(spacing: 20) {
                VStack {
                    Text("현재 온도")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("\(cityWeather.currentTemperatures)")
                }
                VStack {
                    Text("체감 온도")
                        .font(.title3)
                        .fontWeight(.bold)

                    Text("\(cityWeather.feelsTemperatures)")
                }
                VStack {
                    Text("습도")
                        .font(.title3)
                        .fontWeight(.bold)

                    Text("\(cityWeather.currentHumidity)")
                }
                VStack {
                    Text("풍속")
                        .font(.title3)
                        .fontWeight(.bold)

                    Text("\(cityWeather.windSpeed)")
                }
                VStack {
                    Text("기압")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("\(cityWeather.pressure)")
                }
       
            }
        }
    }
}

struct CityWeatherDetail_PreViews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
        CityWeatherDetail(cityWeather: CityWeather.mockData[0])
                .environment(\.locale, .init(identifier: id))
        }
    }
}

