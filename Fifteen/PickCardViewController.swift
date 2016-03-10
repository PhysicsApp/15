//
//  PickCardViewController.swift
//  Fifteen
//
//  Created by Ricardo Lopez Focil on 09/03/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

import UIKit

class PickCardViewController: UIViewController, CardTouchingProtocol {

    @IBOutlet weak var card1: CardView!
    @IBOutlet weak var card2: CardView!
    @IBOutlet weak var card3: CardView!
    @IBOutlet weak var card4: CardView!
    @IBOutlet weak var card5: CardView!
    @IBOutlet weak var card6: CardView!
    @IBOutlet weak var card7: CardView!
    @IBOutlet weak var card8: CardView!
    @IBOutlet weak var card9: CardView!
    
    @IBOutlet weak var playerLabel: UILabel!
    var delegate : PlayerStatusDelegate!
    
    private var array = [CardView]()
    private var selected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        array.append(card2)
        array.append(card1)
        array.append(card3)
        array.append(card4)
        array.append(card5)
        array.append(card6)
        array.append(card7)
        array.append(card8)
        array.append(card9)
    
        let availableCards = delegate!.getAvailableCards()
        
        for i in 0..<array.count{
            array[i].delegate = self
            array[i].hidden = true
        }
        
        for i in 0..<availableCards.count{
            array[i].value = availableCards[i]
            array[i].setHiddenValue(true, animated: false)
            array[i].hidden = false
        }
        
        self.playerLabel.text = "\(self.delegate.getPlayerName()) turn"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func prepareFromSegue(delegate : PlayerStatusDelegate){
        self.delegate = delegate
    }
    
    func cardTouched(card: CardView) {
        
        if selected{
            return
        }
        selected = true
        self.delegate.playerdidGotCard(card.value)
        card.setHiddenValue(false, animated: true){
            _ in
            self.performSegueWithIdentifier("showNew", sender: self)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
