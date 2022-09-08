//
//  CityList.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import SwiftUI

struct CityList: View {
    @EnvironmentObject var repository: Repository
    @EnvironmentObject var imageCacheManager: ImageCacheManager
    @State private var showFavoritesOnly = false
    
    var filteredCities: [CityWeather] {
        repository.cityWeathers.filter { city in
            (!showFavoritesOnly || city.isFavorite)}
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(repository.cityWeathers, id: \.cityName) { cityWeather in
                    NavigationLink {
                        CityWeatherDetail(cityWeather: cityWeather)
                    } label: {
                        CityWeatherRow(cityWeather: cityWeather)
                    }
                }
                .navigationTitle("오늘의 날씨")
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct CityList_Previews: PreviewProvider {
    static var previews: some View {
        CityList()
            .environmentObject(Repository())
            .environmentObject(ImageCacheManager())
    }
}
