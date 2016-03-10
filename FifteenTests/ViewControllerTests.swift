//
//  NamesCheck.swift
//  Fifteen
//
//  Created by Ricardo Lopez Focil on 3/10/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

@testable import Fifteen
import XCTest

class NamesCheck: XCTestCase {
    
    var controller : ViewController!
    
    override func setUp() {
        super.setUp()
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        self.controller = sb.instantiateInitialViewController() as! ViewController
        UIApplication.sharedApplication().windows[0].rootViewController = self.controller
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCasing(){
        self.controller.playerOneField.text = "P1"
        self.controller.playerTwoField.text = "p1"
        XCTAssertFalse(self.controller.validate(), "Two strings with different casing are considered equal")
    }
    
    func testEmpty(){
        self.controller.playerOneField.text = "P1"
        XCTAssert(self.controller.validate(), "A text field may be empty")
        XCTAssertEqual("Player Two", self.controller.playerTwoName)
        
        self.controller.playerOneField.text = ""
        self.controller.playerTwoField.text = "P2"
        XCTAssert(self.controller.validate(), "A text field may be empty")
        XCTAssertEqual("Player One", self.controller.playerOneName)
        
        self.controller.playerTwoField.text = ""
        XCTAssert(self.controller.validate(), "Both text fields may be empty")
        XCTAssertEqual("Player One", self.controller.playerOneName)
        XCTAssertEqual("Player Two", self.controller.playerTwoName)
    }
    
    func testValidation(){
        self.controller.playerOneField.text = "p1"
        self.controller.playerTwoField.text = "p2"
        XCTAssert(self.controller.validate(), "Names that are not equal should pass the test")
        self.controller.playerTwoField.text = "p1"
        XCTAssertFalse(self.controller.validate(), "Names that are equal should not pass the test")
    }
    
    func testPlaceholders(){
        self.controller.playerOneField.text = "Player Two"
        XCTAssertFalse(self.controller.validate(), "Placeholder cross check failed")
        self.controller.playerOneField.text = ""
        self.controller.playerTwoField.text = "Player One"
        XCTAssertFalse(self.controller.validate(), "Placeholder cross check failed")
        XCTAssertEqual(self.controller.playerOneName, "Player One")
    }
    
}
