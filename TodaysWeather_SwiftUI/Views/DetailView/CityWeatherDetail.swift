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
        ZStack {
            Image("nightSky")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .opacity(0.85)
            
            VStack {
                Text(cityWeather.cityName.localize())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Image(uiImage: self.image)
                    .resizable()
                    .frame(width: 130, height: 130)
                Text(cityWeather.weatherCondition.localize())
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .padding(.top, 10)
                
                VStack(spacing: 20) {
                    VStack {
                        Text("현재 온도")
                            .font(.title3)
                            .foregroundColor(Color.white)
                        Text("\(cityWeather.currentTemperatures)\(TemperatureUnit.celsius.symbol)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    VStack {
                        Text("체감 온도")
                            .font(.title3)
                            .foregroundColor(Color.white)
                        Text("\(cityWeather.feelsTemperatures)\(TemperatureUnit.celsius.symbol)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    VStack {
                        Text("습도")
                            .font(.title3)
                            .foregroundColor(Color.white)
                        Text("\(cityWeather.currentHumidity)\(TemperatureUnit.humidity.symbol)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    VStack {
                        Text("풍속")
                            .font(.title3)
                            .foregroundColor(Color.white)
                        Text("\(cityWeather.windSpeed)\(TemperatureUnit.windSpeed.symbol)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    VStack {
                        Text("기압")
                            .font(.title3)
                            .foregroundColor(Color.white)
                        Text("\(cityWeather.pressure)\(TemperatureUnit.pressure.symbol)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    
                }
                .padding(.top)
            }
        }
        .ignoresSafeArea()
    }
}

struct CityWeatherDetail_PreViews: PreviewProvider {
    static var previews: some View {
        ForEach(["ko", "en"], id: \.self) { id in
            CityWeatherDetail(cityWeather: CityWeather.mockData[0])
                .environment(\.locale, .init(identifier: id))
        }
    }
}

