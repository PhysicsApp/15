//
//  MasterFifteenViewController.swift
//  Fifteen
//
//  Created by Ricardo Lopez Focil on 09/03/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

import UIKit

class MasterFifteenViewController: UIViewController, CardTouchingProtocol{

    private var playerCards = [[Int]]()
    private var availableCards : [Int]!
    
    private var currentPlayer = 1
    
    private var playerNames = [String]()
    
    private var usingCards = [CardView]()
    
    @IBOutlet weak var cardOneView : CardView!
    @IBOutlet weak var cardTwoView : CardView!
    @IBOutlet weak var cardThreeView : CardView!

    @IBOutlet weak var playerTurnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.availableCards = createDeck()
        self.playerCards.append([Int]())
        self.playerCards.append([Int]())
        
        self.cardOneView.delegate = self
        self.cardTwoView.delegate = self
        self.cardThreeView.delegate = self
        
        
    }

    private func createDeck()->[Int]{
        var array = [Int]()
        
        for i in 1...9{
            array.append(i)
        }
        
        shufleSpace(&array)
        
        return array
        
    }

    
    func prepareFromSegue(playerOneName : String, playerTwoName : String){
        playerNames.append(playerOneName)
        playerNames.append(playerTwoName)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.cardOneView.setHiddenValue(true, animated: false)
        self.cardTwoView.setHiddenValue(true, animated: false)
        self.cardThreeView.setHiddenValue(true, animated: false)
    }
    
    
    func shufleSpace(inout array : [Int]){
        
        for i in 0...array.count{
            let j = random() & array.count
            (array[i], array[j]) = (array[j], array[i])
        }
        
    }
    
    func cardTouched(card: CardView) {
        //TODO:
    }
    
    
    func startTurn(){
        self.prepareCards()
        //Ensure the rigth player is here
        let controller = UIAlertController(title: "About to start turn", message: "Ensure \(self.playerNames[currentPlayer - 1]) is using the phone", preferredStyle: UIAlertControllerStyle.Alert)
        controller.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { _  in
            if self.playerCards[self.currentPlayer - 1].count == 3{
                self.showCards()
            }
            else{
                self.pickCard()
            }
        }))
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func pickCard(){
        self.performSegueWithIdentifier("pick", sender: self)
    }
    
    func showCards(){
        for c in self.usingCards{
            c.setHiddenValue(false, animated: true)
        }
    }
    
    func prepareCards(){
        
        let useCard : (card : CardView)->() = {
            card in
            self.usingCards.append(card)
            card.hidden = false
        }
        
        self.usingCards.removeAll()
        self.cardOneView.hidden = true
        self.cardTwoView.hidden = true
        self.cardThreeView.hidden = true
        
        switch(playerCards[currentPlayer - 1].count){
        case 1:
            useCard(card: self.cardTwoView)
        case 2:
            useCard(card: self.cardOneView)
            useCard(card: self.cardTwoView)
        case 3:
            useCard(card: self.cardOneView)
            useCard(card: self.cardTwoView)
            useCard(card: self.cardThreeView)
        default:
            break
        }
    }
    
    
    func playerdidDropCard(card : Int){
        //TODO:
    }
    
    func playerdidGotCard(card : Int){
        //TODO:
    }
    
    func playerDidFinishTurn(){
        //TODO:
    }
    
    func getPlayerCards()->[Int]{
        //TODO:
        return [Int]()
    }
    
    func getAvailableCards()->[Int]{
        //TODO:
        return [Int]()
    }

}