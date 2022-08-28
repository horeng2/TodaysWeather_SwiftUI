//
//  ModelData.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/28.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var cityWeathers = Repository().loadCityWeathers()
    
}




