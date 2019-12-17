//
//  PointToTest.swift
//  SpectrumTests
//
//  Created by Andrew Pool on 11/18/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import XCTest
import Spectrum

class PointToTest: XCTestCase {

    let fromLocations = [Vector2(0.0, 0.0)]
    
    let toLocations = [Vector2(100.0, 100.0)]
    
    
    let horizon = Vector2(0,1)
    
  
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print(toLocations[0].angle(with: fromLocations[0]))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
