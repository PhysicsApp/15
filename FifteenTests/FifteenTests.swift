//
//  FifteenTests.swift
//  FifteenTests
//
//  Created by Ricardo Lopez Focil on 09/03/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

import XCTest
@testable import Fifteen

class FifteenTests: XCTestCase {
    
    var statusChecker : MasterFifteenViewController!
    
    override func setUp() {
        super.setUp()
        self.statusChecker = MasterFifteenViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeck(){
    
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
