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
     This method should tell the delegate that the player droped a card and should return the new player's set of cards.
     */
    func playerdidDropCard(card : Card) -> [Card]

    /**
     This method should tell the delegate that the player droped a card and should return the new player's set of cards.
     */
    func playerdidGotCard(card : Card) -> [Card]
    
    /// This method should be called when the match is over and the game should be dismissed.
    func playerDidFinishTurn()
   
}
