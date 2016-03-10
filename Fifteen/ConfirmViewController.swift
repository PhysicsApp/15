//
//  ConfirmViewController.swift
//  Fifteen
//
//  Created by Ricardo Lopez Focil on 3/9/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {

    @IBOutlet weak var playerLabelTurn: UILabel!

    @IBOutlet weak var card1: CardView!
    @IBOutlet weak var card2: CardView!
    @IBOutlet weak var card3: CardView!
    
    private var array = [CardView]()
    private var delegate : PlayerStatusDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        array.append(card2)
        array.append(card1)
        array.append(card3)
        
        for i in array{
            i.setHiddenValue(false, animated: false)
            i.hidden = true
            i.userInteractionEnabled = false
        }
        
        self.playerLabelTurn.text = "\(delegate.getPlayerName()) turn"
        
        let cards = delegate.getPlayerCards()
        for i in 0..<cards.count{
            array[i].value = cards[i]
            array[i].hidden = false
        }
        
    }
    
    func prepareFromSegue(delegate : PlayerStatusDelegate){
        self.delegate = delegate
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "win"{
            let controller = segue.destinationViewController as! FinishViewController
            controller.prepareFromSegue(self.delegate)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done(sender: AnyObject) {
        if hasWon(){
            self.performSegueWithIdentifier("win", sender: self)
        }
        else{
            self.delegate.playerDidFinishTurn()
        }
    }
    
    func hasWon()->Bool{
        
        if delegate.getPlayerCards().count != 3{
            return false
        }
        else{
            var sum = 0
            for i in delegate.getPlayerCards(){
                sum += i
            }
            if sum == 15{
                return true
            }
            else{
                return false
            }
        }
    }
}
