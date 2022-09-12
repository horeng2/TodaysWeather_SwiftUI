//
//  DIContainer.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/11.
//

import Foundation

class DIContainer {
    static let shared = DIContainer()
    private var dependencies = [String: Any]()
    
    func register<T>(_ dependency: T) {
        let key = String(describing: type(of: T.self))
        self.dependencies[key] = dependency
    }
    
    func resolve<T>() -> T {
        let key = String(describing: type(of: T.self))
        let dependency = dependencies[key]
        
        precondition(dependency != nil, "register되지 않은 \(key)입니다.")
        
        return dependency as! T
    }
}
