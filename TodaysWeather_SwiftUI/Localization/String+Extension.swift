//
//  String+Extension.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/12.
//

import Foundation
import SwiftUI

extension String {
    func localize() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}


 
