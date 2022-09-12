//
//  TodaysWeather_SwiftUITests.swift
//  TodaysWeather_SwiftUITests
//
//  Created by 서녕 on 2022/08/27.
//

import XCTest
@testable import TodaysWeather_SwiftUI

class TodaysWeather_SwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        UserDefaults.standard.set(1, forKey: "test")

        XCTAssertEqual(UserDefaults.standard.integer(forKey: "test"), 2)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
