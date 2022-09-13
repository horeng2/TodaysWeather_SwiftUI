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
    }
    
    var body: some View {
            NavigationView {
                ZStack {
                    Image("sky")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .opacity(1)
                List {
                    ForEach(listViewModel.weatherDataSource, id: \.cityName) { cityWeather in
                        NavigationLink {
                            CityWeatherDetail(cityWeather: cityWeather)
                        } label: {
                            CityWeatherRow(cityWeather: cityWeather)
                        }
                    }
                    .navigationTitle("오늘의 날씨")
                    .listRowSeparatorTint(Color.gray)
                    .listRowBackground(Color.clear)
                }
                .onAppear(perform: listViewModel.weather)
                .listStyle(PlainListStyle())
                .padding(.top, 90)
            }
        }
            
    }
}

struct CityList_Previews: PreviewProvider {
    static var previews: some View {
        let listViewModel: CityListViewModel = DIContainer.shared.resolve()
        CityList(viewModel: listViewModel)
    }
}
