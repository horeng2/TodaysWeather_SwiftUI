//
//  TodaysWeather_SwiftUIApp.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/08/27.
//

import SwiftUI

@main
struct TodaysWeather_SwiftUIApp: App {
    @StateObject private var repository = Repository()
    @StateObject private var imageCacheManager = ImageCacheManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(repository)
                .environmentObject(imageCacheManager)
        }
    }
}
