//
//  CityRowView.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/27.
//

import SwiftUI

struct CityRowView: View {
    @State var image = UIImage()
    var cityWeather: CityWeather
    
    var body: some View {
        content
            .frame(height: 30)
            .padding()
    }
    
    private var content: some View {
        HStack() {
            weatherIconView(cityWeather.weatherCondition)
            cityNameView()
            Spacer()
            weatherInfoView()
        }
    }
}

// MARK: - Displaying View
extension CityRowView {
    private func weatherInfoView() -> some View {
        VStack {
            Text("☀️ \(cityWeather.currentTemperatures)")
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
            Text("💧 \(cityWeather.humidity)")
                .font(.headline)
                .fontWeight(.bold)
        }
    }
    
    private func cityNameView() -> some View {
        Text(cityWeather.cityName.localize())
            .font(.title2)
            .fontWeight(.bold)
    }
}

// MARK: - Load Icon Image
extension CityRowView {
    private func weatherIconView(_ weather: WeatherCondition) -> some View {
        Image("\(weather.rawValue)")
            .resizable()
            .frame(width: 40, height: 40)
            .padding(.trailing, 15)
    }
}

struct CityWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
            CityRowView(cityWeather: CityWeather.mockData[0])
                .environment(\.locale, .init(identifier: id))
        }
    }
}
