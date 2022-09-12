//
//  Double+Extension.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/12.
//

import Foundation

extension Double {
    func roundToInt() -> Int {
        return Int(self.rounded())
    }
}
