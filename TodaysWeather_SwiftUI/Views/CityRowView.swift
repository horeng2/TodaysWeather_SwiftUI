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
            .onAppear {
                loadWeatherInfo()
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
            weatherInfoView()
        }
        .frame(height: 30)
        .padding()
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
}

// MARK: - Load ImgaeCacheManager
extension CityRowView {
    private func loadWeatherInfo() {
        ImageCacheManager.shared.loadImage(url: cityWeather.iconURL)
        DispatchQueue.main.async {
            self.image = ImageCacheManager.shared.image
        }
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
