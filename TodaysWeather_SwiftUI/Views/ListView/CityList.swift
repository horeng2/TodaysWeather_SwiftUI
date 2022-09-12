//
//  CityList.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import SwiftUI

struct CityList: View {
    @ObservedObject var listViewModel: CityListViewModel

    init(viewModel: CityListViewModel) {
        self.listViewModel = viewModel
        self.listViewModel.weather()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(listViewModel.weatherDataSource, id: \.cityName) { cityWeather in
                    NavigationLink {
                        CityWeatherDetail(cityWeather: cityWeather)
                    } label: {
                        CityWeatherRow(cityWeather: cityWeather)
                    }
                }
                .navigationTitle("오늘의 날씨")
            }
            .onAppear(perform: listViewModel.weather)
            .listStyle(PlainListStyle())
        }
    }
}

struct CityList_Previews: PreviewProvider {
    static var previews: some View {
        let listViewModel: CityListViewModel = DIContainer.shared.resolve()
        CityList(viewModel: listViewModel)
    }
}
