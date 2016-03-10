//
//  ViewController.swift
//  Fifteen
//
//  Created by Ricardo Lopez Focil on 09/03/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerTwoField: UITextField!
    @IBOutlet weak var playerOneField: UITextField!
    
    var playerOneName: String!
    var playerTwoName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! UINavigationController
        let master = destination.viewControllers.first as! MasterFifteenViewController
        master.prepareFromSegue(playerOneName, playerTwoName: playerTwoName)
    }

    @IBAction func setNames(sender: UIButton){
        
        
        if(!validate()){
            let alertController = UIAlertController(title: "Error", message:
                "Names can not be equal", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        super.performSegueWithIdentifier("navFromNames", sender: self)
    }
    
    func validate()->Bool{
        if(!playerOneField.text!.isEmpty){
            self.playerOneName = playerOneField.text!
        }
        else{
            self.playerOneName = playerOneField.placeholder!
        }
        
        if(!playerTwoField.text!.isEmpty){
            self.playerTwoName = playerTwoField.text!
        }
        else{
            self.playerTwoName = playerTwoField.placeholder!
        }
        
        if(playerOneName.lowercaseString == playerTwoName.lowercaseString){
            return false
        }
        
        return true
    }
}

