//
//  CityRow.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/27.
//

import SwiftUI

struct CityRow: View {
    var body: some View {
        HStack {
            Text("서울")
                .font(.title2)
            Spacer()
            
            VStack {
                Text("온도")
                    .font(.subheadline)
                Text("습도")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow()
    }
}
