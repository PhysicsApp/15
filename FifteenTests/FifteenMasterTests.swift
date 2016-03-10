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
        let sb = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        self.statusChecker = sb.instantiateViewControllerWithIdentifier("master") as! MasterFifteenViewController
        self.statusChecker.prepareFromSegue("P1", playerTwoName: "P2")
        UIApplication.sharedApplication().windows[0].rootViewController = self.statusChecker
    }
    
    override func tearDown() {
        self.statusChecker.dismissViewControllerAnimated(false, completion: nil)
        super.tearDown()
    }

    
    func testDeck(){
        let deck = self.statusChecker.getAvailableCards()
        XCTAssert(deck.count == 9)
        
        var sorted = true
        for i in 1...9{
            if i != deck[i]{
                sorted = false
                break
            }
        }
        XCTAssertFalse(sorted, "The array should not be sorted")

        //Shuffling the deck changes its original order
        var array2 = deck
        statusChecker.shufleSpace(&array2)
        sorted = false
        for i in 1..<9{
            if array2[i] != deck[i]{
                sorted = false
                break
            }
        }
        XCTAssertFalse(sorted, "The array should have change its order")
    }
    
    func testDeckCards(){
        let deck = self.statusChecker.getAvailableCards()
        let sortedDeck = deck.sort()
        for i in 1...9{
            XCTAssertEqual(sortedDeck[i - 1], i)
        }
    }
    
    func testPlayerInitialStatus(){
        XCTAssert(self.statusChecker.getPlayerCards().count == 0)
        self.statusChecker.playerdidGotCard(2)
        self.statusChecker.playerDidFinishTurn() //force player change
        XCTAssertEqual(self.statusChecker.getPlayerCards().count, 0)
    }
    
    
    func testAvailability(){
        self.statusChecker.playerdidGotCard(3)
        let index = self.statusChecker.getAvailableCards().indexOf(3)
        XCTAssertNil(index, "Card should not be available")
        XCTAssertNotEqual(self.statusChecker.getPlayerCards().indexOf(3), nil, "Player should have the card now")
        //Force take 3 cards
        
        self.statusChecker.playerDidFinishTurn() //p2
        moveToDrop()

        //Test
        XCTAssert(self.statusChecker.playerdidDropCard(3), "Player had the card")
        XCTAssertNil(self.statusChecker.getPlayerCards().indexOf(3), "The card should not be in the player cards array")
        XCTAssertNotEqual(self.statusChecker.getAvailableCards().indexOf(3), nil)
        
    }
    
    func testPlayerOrdering(){
        
        XCTAssert(statusChecker.playerdidGotCard(3))
        XCTAssertFalse(statusChecker.playerdidGotCard(4), "A player must not take two cards")
        XCTAssertNotEqual(statusChecker.getPlayerCards().indexOf(3), nil, "Check that fitst card was taken")
        XCTAssertEqual(statusChecker.getPlayerCards().indexOf(4), nil, "Check second was not taken")
        XCTAssertFalse(statusChecker.playerdidDropCard(3), "The player cant drop cards. He has already picked one")
        
        self.statusChecker.playerDidFinishTurn()
        XCTAssert(statusChecker.playerdidGotCard(4))
        self.statusChecker.playerDidFinishTurn()
        XCTAssertFalse(self.statusChecker.playerdidDropCard(3), "Player has less than three cards so he cant drop")
        XCTAssertNotEqual(statusChecker.getPlayerCards().indexOf(3), nil, "Check that player still has the card")
        XCTAssertNil(statusChecker.getAvailableCards().indexOf(3), "The card should not be available")
        
        moveToDrop()
        XCTAssertTrue(self.statusChecker.playerdidDropCard(3), "Player should be able to drop cards at this point")
        let card = self.statusChecker.getPlayerCards().first!
        XCTAssertFalse(self.statusChecker.playerdidDropCard(card), "Player should not drop more tahn 1 card in his turn")
        XCTAssertNil(self.statusChecker.getAvailableCards().indexOf(card), "The card should not be available")
        XCTAssertNotEqual(self.statusChecker.getPlayerCards().indexOf(card), nil, "The player should have the card")
        
    }
    
    func testConsistency(){
        
        self.statusChecker.playerdidGotCard(self.statusChecker.getAvailableCards().first!)
        XCTAssertFalse(self.statusChecker.playerdidDropCard(self.statusChecker.getPlayerCards().first!), "Player can't drop after taking card")
        XCTAssertEqual(1, self.statusChecker.getPlayerCards().count)
        
        moveToDrop()
        XCTAssertFalse(self.statusChecker.playerdidGotCard(self.statusChecker.getAvailableCards().first!), "Player with three cards must not take another one before droping")
        XCTAssertEqual(self.statusChecker.getPlayerCards().count, 3)
        XCTAssertFalse(self.statusChecker.playerdidDropCard(self.statusChecker.getAvailableCards().first!), "Playter can't drop a card that he doesen't own")
        XCTAssert(self.statusChecker.playerdidDropCard(self.statusChecker.getPlayerCards().first!), "A player should be able to drop a card he owns when he has three cards")
        XCTAssertEqual(2, self.statusChecker.getPlayerCards().count)
        XCTAssert(self.statusChecker.playerdidGotCard(self.statusChecker.getAvailableCards().first!), "The player has now 2 cards so he can pick a card")
        XCTAssertFalse(self.statusChecker.playerdidDropCard(self.statusChecker.getPlayerCards().first!), "The player already got a card so he can't drop")
        
        //Go back to player 1 with three cards
        moveToDrop()
        XCTAssertFalse(self.statusChecker.playerDidFinishTurn(), "Player should pick a card")
        self.statusChecker.playerdidDropCard(self.statusChecker.getPlayerCards().first!)
        XCTAssertFalse(self.statusChecker.playerDidFinishTurn(), "Player should pick a card")
        self.statusChecker.playerdidGotCard(self.statusChecker.getAvailableCards().first!)
        XCTAssert(self.statusChecker.playerDidFinishTurn(), "Player can finish turn now")

    }
    
    func testPickingAndDropping(){
        self.statusChecker.playerdidGotCard(self.statusChecker.getAvailableCards().first!)
        self.statusChecker.playerDidFinishTurn()
        self.statusChecker.playerdidGotCard(self.statusChecker.getAvailableCards().first!)
        self.statusChecker.playerDidFinishTurn()
        
        var playerTwoCards = [1,2,3,4,5,6,7,8,9]
        for i in self.statusChecker.getAvailableCards(){
            let index = playerTwoCards.indexOf(i)!
            playerTwoCards.removeAtIndex(index)
        }
        for i in self.statusChecker.getPlayerCards(){
            let index = playerTwoCards.indexOf(i)!
            playerTwoCards.removeAtIndex(index)
        }
        
        XCTAssertFalse(self.statusChecker.playerdidGotCard(self.statusChecker.getPlayerCards().first!), "A player can't take a card he already owns")
        XCTAssertFalse(self.statusChecker.playerdidGotCard(playerTwoCards.first!), "A player can't take a card the other player owns")
        XCTAssert(self.statusChecker.playerdidGotCard(self.statusChecker.getAvailableCards().first!), "The player can take an available card")
        
        moveToDrop()
        XCTAssertFalse(self.statusChecker.playerdidGotCard(self.statusChecker.getAvailableCards().first!), "The player can't take a card if he already have 3")
        XCTAssertEqual(3, self.statusChecker.getPlayerCards().count)
        XCTAssert(self.statusChecker.playerdidDropCard(self.statusChecker.getPlayerCards().first!), "The player should be able to drop card as he has 3")
    }
    
    func testNames(){
        XCTAssertEqual("P1", self.statusChecker.getPlayerName())
        self.statusChecker.playerdidGotCard(1)
        self.statusChecker.playerDidFinishTurn()
        XCTAssertEqual("P2", self.statusChecker.getPlayerName())
        self.statusChecker.prepareFromSegue("P3", playerTwoName: "P4")
        XCTAssertNotEqual("P3", self.statusChecker.getPlayerName())
        XCTAssertNotEqual("P4", self.statusChecker.getPlayerName())
    }
    
    func moveToDrop(){
        self.statusChecker.playerDidFinishTurn()
        while self.statusChecker.getCurrentPlayer() != 1 || self.statusChecker.getPlayerCards().count != 3{
            
            if self.statusChecker.getPlayerCards().count == 3{
                self.statusChecker.playerdidDropCard(self.statusChecker.getPlayerCards().first!)
            }
            
            self.statusChecker.playerdidGotCard(self.statusChecker.getAvailableCards().first!)
            self.statusChecker.playerDidFinishTurn()
            
        }
    }
    
}


