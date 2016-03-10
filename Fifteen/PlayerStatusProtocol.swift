//
//  PlayerStatusProtocol.swift
//  Fifteen
//
//  Created by Ricardo Lopez Focil on 09/03/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

import UIKit

protocol PlayerStatusDelegate{
    
    /**      
     This method should tell the delegate that the player droped a card and should return if the operation succeded
     */
    func playerdidDropCard(card : Int) -> Bool

    /**
     This method should tell the delegate that the player droped a card and should return the new player's set of cards.
     */
    func playerdidGotCard(card : Int) -> Bool
    
    /// This method should be called when the turn is over and the game should be dismissed.
    func playerDidFinishTurn() -> Bool
    
    /// Returns the cards currently held by the user
    func getPlayerCards()->[Int]
    
    /// Returns the currently available set of cards
   func getAvailableCards()->[Int]
    
    func getPlayerName()->String
    
    func gameDidEnded()
    
    func getCurrentPlayer()->Int
}
