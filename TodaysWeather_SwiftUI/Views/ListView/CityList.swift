//
//  CityList.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import SwiftUI

struct CityList: View {
    @Binding var dataSource: [CityWeather]
    @State var isLoading = true

    var body: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
                .task(loadingView)
            
        } else {
            content
        }
    }
    
    var content: some View {
        NavigationView {
            ZStack {
                Image("sky")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .opacity(1)
            List {
                ForEach(dataSource, id: \.cityName) { cityWeather in
                    NavigationLink {
                        CityWeatherDetail(cityWeather: cityWeather)
                    } label: {
                        CityWeatherRow(cityWeather: cityWeather)
                    }
                }
                .navigationTitle("오늘의 날씨".localize())
                .listRowSeparatorTint(Color.gray)
                .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
            .padding(.top, 90)
        }
    }
    }
}

extension CityList {
    @Sendable
    func loadingView() async {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        self.isLoading = false
    }
}

struct CityList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["ko", "en"], id: \.self) { id in
            CityList(dataSource: .constant(CityWeather.mockData))
                .environment(\.locale, .init(identifier: id))
        }
    }
}
