//
//  CityListView.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import SwiftUI

struct CityListView: View {
    @State var isLoading = true
    @Binding var dataSource: [CityWeather]
    
    var body: some View {
        if isLoading {
            LoadingView(isLoading: $isLoading)
        } else {
            content
        }
    }

    var content: some View {
        NavigationView {
            cityListView()
        }
    }
}

extension CityListView {
    func cityListView() -> some View {
        List {
            ForEach(dataSource, id: \.cityName) { cityWeather in
                makeNavigationLink(of: cityWeather)
            }
            .navigationTitle("오늘의 날씨".localize())
            .listRowSeparatorTint(Color.gray)
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
        .padding(.top)
    }
    
    func makeNavigationLink(of weather: CityWeather) -> some View {
        NavigationLink {
            WeatherDetailView(cityWeather: weather)
        } label: {
            CityRowView(cityWeather: weather)
        }
    }
}

struct CityList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["ko", "en"], id: \.self) { id in
            CityListView(isLoading: false, dataSource: .constant(CityWeather.mockData))
                .environment(\.locale, .init(identifier: id))
        }
    }
}
