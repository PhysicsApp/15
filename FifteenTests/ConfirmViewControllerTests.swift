//
//  ConfirmViewControllerTests.swift
//  Fifteen
//
//  Created by Ricardo Lopez Focil on 3/10/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

import XCTest
@testable import Fifteen

class ConfirmViewControllerTests: XCTestCase {

    var statusChecker : MasterFifteenViewController!
    var pickCardController : PickCardViewController!
    var confirmController : ConfirmViewController!
    
    override func setUp() {
        super.setUp()
        UIView.setAnimationsEnabled(false)
        let sb = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        self.statusChecker = sb.instantiateViewControllerWithIdentifier("master") as! MasterFifteenViewController
        self.statusChecker.prepareFromSegue("P1", playerTwoName: "P2")
        _ = self.statusChecker.view
        
        self.confirmController = sb.instantiateViewControllerWithIdentifier("confirm") as! ConfirmViewController
        self.confirmController.prepareFromSegue(self.statusChecker)
        _ = self.confirmController.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWinningTwoCards(){
    

        giveCardPlayerAndResignTurn(7)
        giveCardPlayerAndResignTurn(1)
        
        self.statusChecker.playerdidGotCard(8)
        XCTAssertFalse(self.confirmController.hasWon(), "Player cant win with two cards" )
        
    }
    
    func testWinning(){
        
    }
    
    func giveCardPlayerAndResignTurn(card : Int){
        if self.statusChecker.getPlayerCards().count == 3{
            self.statusChecker.playerdidDropCard(self.statusChecker.getPlayerCards().first!)
        }
        
        self.statusChecker.playerdidGotCard(card)
        self.statusChecker.playerDidFinishTurn()
    }
    
}
