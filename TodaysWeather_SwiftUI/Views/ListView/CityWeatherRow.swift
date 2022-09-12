//
//  CityRow.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/27.
//

import SwiftUI

struct CityWeatherRow: View {
    @State var image = UIImage()
    var cityWeather: CityWeather

    var body: some View {
        content
            .onAppear {
                    ImageCacheManager.shared.loadImage(url: cityWeather.iconURL)
                DispatchQueue.main.async {
                    self.image = ImageCacheManager.shared.image
                }
            }
    }
    
    private var content: some View {
        HStack() {
            Image(uiImage: self.image)
                .resizable()
                .frame(width: 50, height: 50)
            Text(cityWeather.cityName.localize())
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            VStack {
                HStack {
                    Text("☀️ \(cityWeather.currentTemperatures)\(TemperatureUnit.celsius.symbol)")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                Spacer()
                HStack {
                    Text("💧 \(cityWeather.currentHumidity)\(TemperatureUnit.humidity.symbol)")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
        }
        .frame(height: 40)
        .padding()
    }
}

struct CityWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
            CityWeatherRow(cityWeather: CityWeather.mockData[0])
                .environment(\.locale, .init(identifier: id))
        }
    }
}
