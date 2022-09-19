//
//  WeatherDetailView.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import SwiftUI

struct WeatherDetailView: View {
    var cityWeather: CityWeather
    
    var body: some View {
        ZStack {
            backgroundImageView()
            content
        }
        .ignoresSafeArea()
    }
    
    var content: some View {
        VStack {
            cityNameView()
            weatherIconView(cityWeather.weatherCondition)
            descriptionView()
            weatherInfoView()
        }
    }
}

// MARK: - Displaying View
extension WeatherDetailView {
    private func backgroundImageView() -> some View {
        Image("nightSky")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .opacity(0.85)
    }
    
    private func cityNameView() -> some View {
        Text(cityWeather.cityName.localize())
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.white)
    }
    
    private func descriptionView() -> some View {
        Text(cityWeather.weatherCondition.rawValue.localize())
            .font(.title2)
            .foregroundColor(Color.white)
            .padding(.top)
    }
    
    private func weatherInfoView() -> some View {
        VStack(spacing: 20) {
            weatherDetail(title: "현재 온도", info: cityWeather.currentTemperatures)
            weatherDetail(title: "체감 온도", info: cityWeather.feelsTemperatures)
            weatherDetail(title: "습도", info: cityWeather.humidity)
            weatherDetail(title: "풍속", info: cityWeather.windSpeed)
            weatherDetail(title: "기압", info: cityWeather.pressure)
        }
        .padding(.top)
    }
    
    private func weatherDetail(title: String, info: String) -> some View {
        VStack {
            Text(title)
                .font(.title3)
                .foregroundColor(Color.white)
            Text(info)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
        }
    }
}

// MARK: - Load Icon Image
extension WeatherDetailView {
    private func weatherIconView(_ weather: WeatherCondition) -> some View {
        Image("\(weather.rawValue)")
            .resizable()
            .frame(width: 120, height: 120)
    }
}

struct CityWeatherDetail_PreViews: PreviewProvider {
    static var previews: some View {
        ForEach(["ko", "en"], id: \.self) { id in
            WeatherDetailView(cityWeather: CityWeather.mockData[0])
                .environment(\.locale, .init(identifier: id))
        }
    }
}

