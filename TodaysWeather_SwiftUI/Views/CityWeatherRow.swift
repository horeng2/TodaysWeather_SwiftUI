//
//  CityRow.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/27.
//

import SwiftUI

struct CityWeatherRow: View {
    @EnvironmentObject var imageCacheManager: ImageCacheManager
    @State var image = UIImage()
    var cityWeather: CityWeather
    
    var body: some View {
        content
            .onAppear {
                self.imageCacheManager.loadImage(url: cityWeather.iconURL)
                self.image = self.imageCacheManager.image
            }
    }
    
    private var content: some View {
        HStack() {
            Image(uiImage: self.image)
                .resizable()
                .frame(width: 60, height: 60)

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
        .frame(height: 40)
        .padding()
    }
}