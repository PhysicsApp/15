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
    
}
