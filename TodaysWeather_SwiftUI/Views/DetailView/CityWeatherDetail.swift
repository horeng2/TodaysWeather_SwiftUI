//
//  CityWeatherDetail.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import SwiftUI

struct CityWeatherDetail: View {
    @EnvironmentObject var imageCacheManager: ImageCacheManager
    @EnvironmentObject var repository: WeatherRepository
    var cityWeather: CityWeather
    @State var image = UIImage()
    
    var body: some View {
        content
            .onAppear {
                self.imageCacheManager.loadImage(url: cityWeather.iconURL)
                self.image = imageCacheManager.image
            }
    }
    
    var content: some View {
        VStack {
            Image(uiImage: self.image)
            Text(cityWeather.cityName.rawValue)
                .font(.title)
            Text(cityWeather.description)

            VStack(spacing: 20) {
                VStack {
                    Text("현재 온도")
                    Text("\(cityWeather.currentTemperatures)")
                }
                VStack {
                    Text("체감 온도")
                    Text("\(cityWeather.feelsTemperatures)")
                }
                VStack {
                    Text("습도")
                    Text("\(cityWeather.currentHumidity)")
                }
                VStack {
                    Text("풍속")
                    Text("\(cityWeather.windSpeed)")
                }
                VStack {
                    Text("기압")
                    Text("\(cityWeather.pressure)")
                }
       
            }
        }
    }
}

struct CityWeatherDetail_PreViews: PreviewProvider {
    static var previews: some View {
        CityWeatherDetail(cityWeather: CityWeather.mockData[0])
            .environmentObject(WeatherRepository())
            .environmentObject(ImageCacheManager())
    }
}

